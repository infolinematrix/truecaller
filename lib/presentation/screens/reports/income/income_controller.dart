import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/models/transactions_model.dart';
import 'package:truecaller/data/source/objectstore.dart';
import 'package:truecaller/objectbox.g.dart';
import 'package:truecaller/utils/index.dart';

final accountBox = store!.objStore.box<AccountsModel>();
final transactionBox = store!.objStore.box<TransactionsModel>();
final isFilterProvider = StateProvider.autoDispose<bool>((ref) => false);

class DateRangeModel {
  final DateTime startDate;
  final DateTime endDate;

  DateRangeModel(this.startDate, this.endDate);
}

final dateRangeProvider = StateProvider.autoDispose<DateRangeModel>((ref) {
  return DateRangeModel(firstDayOfMonth(), lastDayOfMonth());
});

final incomeStatementProvider = AsyncNotifierProvider.autoDispose<
    AccountTransactions, List<TransactionsModel>>(() {
  return AccountTransactions();
});

class AccountTransactions
    extends AutoDisposeAsyncNotifier<List<TransactionsModel>> {
  @override
  FutureOr<List<TransactionsModel>> build() {
    try {
      final DateTime startDate = ref.watch(dateRangeProvider).startDate;
      final DateTime endtDate =
          ref.watch(dateRangeProvider).endDate.add(const Duration(days: 1));

      QueryBuilder<TransactionsModel> builder = transactionBox.query(
          TransactionsModel_.account.notEquals(0) &
              TransactionsModel_.txnType.equals('RECEIVE') &
              TransactionsModel_.txnDate
                  .greaterOrEqual(startDate.millisecondsSinceEpoch) &
              TransactionsModel_.txnDate
                  .lessOrEqual(endtDate.millisecondsSinceEpoch))
        ..order(
          TransactionsModel_.txnDate,
          flags: Order.caseSensitive,
        );

      Query<TransactionsModel> query = builder.build();
      final data = query.find().toList();

      query.close();
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
