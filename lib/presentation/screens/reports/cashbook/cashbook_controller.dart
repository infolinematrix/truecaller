import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/data/models/transactions_model.dart';
import 'package:truecaller/data/repositories/transaction_repository.dart';
import 'package:truecaller/objectbox.g.dart';

// final cashbookProvider = StateNotifierProvider.autoDispose<
//     CashBookStateNotifier, AsyncValue<List<TransactionsModel>>>((ref) {
//   return CashBookStateNotifier(ref);
// });

// class CashBookStateNotifier
//     extends StateNotifier<AsyncValue<List<TransactionsModel>>> {
//   final Ref ref;
//   CashBookStateNotifier(this.ref)
//       : super(const AsyncValue<List<TransactionsModel>>.loading()) {
//     getTransactions();
//   }

//   getTransactions() async {
//     QueryBuilder<TransactionsModel> builder = TransactionRepository()
//         .transactionBox
//         .query(TransactionsModel_.txnDate.notNull() &
//             TransactionsModel_.txnMode.equals('CASH') &
//             TransactionsModel_.txnDate
//                 .greaterOrEqual(firstDayOfMonth().millisecondsSinceEpoch) &
//             TransactionsModel_.txnDate
//                 .lessOrEqual(lastDayOfMonth().millisecondsSinceEpoch))
//       ..order(TransactionsModel_.txnDate, flags: Order.descending);

//     Query<TransactionsModel> query = builder.build();
//     List<TransactionsModel> data = query.find().toList();
//     query.close();

//     state = AsyncValue<List<TransactionsModel>>.data(data);
//   }
// }

final isFilterProvider = StateProvider.autoDispose<bool>((ref) => false);
//---CASH BOOK

class DateRangeModel {
  final DateTime startDate;
  final DateTime endDate;

  DateRangeModel(this.startDate, this.endDate);
}

final dateRangeProvider = StateProvider.autoDispose<DateRangeModel>((ref) {
  return DateRangeModel(
      DateTime.now().subtract(const Duration(days: 7)), DateTime.now());
});

final cashBookProvider =
    AsyncNotifierProvider.autoDispose<CashBookState, List<TransactionsModel>>(
        () {
  return CashBookState();
});

class CashBookState extends AutoDisposeAsyncNotifier<List<TransactionsModel>> {
  @override
  FutureOr<List<TransactionsModel>> build() {
    try {
      final DateTime startDate = ref.watch(dateRangeProvider).startDate;
      final DateTime endtDate =
          ref.watch(dateRangeProvider).endDate.add(const Duration(days: 1));

      QueryBuilder<TransactionsModel> builder = TransactionRepository()
          .transactionBox
          .query(TransactionsModel_.txnDate.notNull() &
              TransactionsModel_.txnMode.equals('CASH') &
              TransactionsModel_.txnDate
                  .greaterOrEqual(startDate.millisecondsSinceEpoch) &
              TransactionsModel_.txnDate
                  .lessOrEqual(endtDate.millisecondsSinceEpoch))
        ..order(TransactionsModel_.txnDate, flags: Order.descending);

      Query<TransactionsModel> query = builder.build();
      List<TransactionsModel> data = query.find().toList();
      query.close();

      return data;
    } catch (e) {
      rethrow;
    }
  }
}
