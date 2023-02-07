import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/models/transactions_model.dart';
import 'package:truecaller/data/source/objectstore.dart';
import 'package:truecaller/objectbox.g.dart';

final accountBox = store!.objStore.box<AccountsModel>();
final transactionBox = store!.objStore.box<TransactionsModel>();
final isFilterProvider = StateProvider.autoDispose<bool>((ref) => false);

//--TRANSACTIONS PROVIDE (ACCOUNT WISE)
// final transactionsProvider = StateNotifierProvider.autoDispose
//     .family<TransactionState, AsyncValue<List<TransactionsModel>>, int>(
//         (ref, accountNo) {
//   return TransactionState(accountNo: accountNo);
// });

// class TransactionState
//     extends StateNotifier<AsyncValue<List<TransactionsModel>>> {
//   final int accountNo;
//   TransactionState({required this.accountNo})
//       : super(const AsyncValue<List<TransactionsModel>>.loading()) {
//     getTransactions();
//   }

//   getTransactions() async {
//     try {
//       QueryBuilder<TransactionsModel> builder = transactionBox
//           .query(TransactionsModel_.account.equals(accountNo))
//         ..order(TransactionsModel_.txnDate, flags: Order.caseSensitive);

//       Query<TransactionsModel> query = builder.build();
//       List<TransactionsModel> data = query.find().toList();

//       query.close();
//       state = AsyncValue<List<TransactionsModel>>.data(data);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<bool> delete({required int txnId}) async {
//     try {
//       transactionBox.remove(txnId);
//       getTransactions();
//       return true;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

//-- ACCOUNT TRANSACTION DATE RANGE WISE

class DateRangeModel {
  final DateTime startDate;
  final DateTime endDate;

  DateRangeModel(this.startDate, this.endDate);
}

final dateRangeProvider = StateProvider.autoDispose<DateRangeModel>((ref) {
  return DateRangeModel(
      DateTime.now().subtract(const Duration(days: 7)), DateTime.now());
});

final accountTransactions = AsyncNotifierProvider.family
    .autoDispose<AccountTransactions, List<TransactionsModel>, Map>(() {
  return AccountTransactions();
});

class AccountTransactions
    extends AutoDisposeFamilyAsyncNotifier<List<TransactionsModel>, Map> {
  @override
  FutureOr<List<TransactionsModel>> build(Map arg) {
    try {
      final DateTime startDate = ref.watch(dateRangeProvider).startDate;
      final DateTime endtDate =
          ref.watch(dateRangeProvider).endDate.add(const Duration(days: 1));

      QueryBuilder<TransactionsModel> builder = transactionBox.query(
          TransactionsModel_.account.equals(arg['accountNo']) &
              TransactionsModel_.txnDate
                  .greaterOrEqual(startDate.millisecondsSinceEpoch) &
              TransactionsModel_.txnDate
                  .lessOrEqual(endtDate.millisecondsSinceEpoch))
        ..order(TransactionsModel_.txnDate, flags: Order.caseSensitive);

      Query<TransactionsModel> query = builder.build();
      final data = query.find().toList();

      query.close();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  //--DELETE
  Future<bool> delete({required int txnId}) async {
    try {
      transactionBox.remove(txnId);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
