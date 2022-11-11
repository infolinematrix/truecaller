import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/data/models/transactions_model.dart';
import 'package:truecaller/data/repositories/transaction_repository.dart';
import 'package:truecaller/objectbox.g.dart';
import 'package:truecaller/utils/index.dart';

//--DAILY
final dailyTransactions = StateNotifierProvider.autoDispose<
    DailyTransactionsStateNotifier, AsyncValue<List<TransactionsModel>>>((ref) {
  return DailyTransactionsStateNotifier(ref);
});

class DailyTransactionsStateNotifier
    extends StateNotifier<AsyncValue<List<TransactionsModel>>> {
  final Ref ref;
  DailyTransactionsStateNotifier(this.ref)
      : super(const AsyncValue<List<TransactionsModel>>.loading()) {
    getTransactions();
  }

  getTransactions() async {
    QueryBuilder<TransactionsModel> builder = TransactionRepository()
        .transactionBox
        .query(TransactionsModel_.txnDate
                .notNull()
                .and(TransactionsModel_.txnType.equals('PAYMENT'))
                .or(TransactionsModel_.txnType.equals('RECEIVE')) &
            TransactionsModel_.txnDate
                .greaterOrEqual(dateTodayStart().millisecondsSinceEpoch))
      ..order(TransactionsModel_.txnDate, flags: Order.descending);

    Query<TransactionsModel> query = builder.build();
    List<TransactionsModel> data = query.find().toList();
    query.close();

    state = AsyncValue<List<TransactionsModel>>.data(data);
  }
}

//---MONTHLY
final monthlyTransactions = StateNotifierProvider.autoDispose<
    MonthlyTransactionsStateNotifier,
    AsyncValue<List<TransactionsModel>>>((ref) {
  return MonthlyTransactionsStateNotifier(ref);
});

class MonthlyTransactionsStateNotifier
    extends StateNotifier<AsyncValue<List<TransactionsModel>>> {
  final Ref ref;
  MonthlyTransactionsStateNotifier(this.ref)
      : super(const AsyncValue<List<TransactionsModel>>.loading()) {
    getTransactions();
  }

  getTransactions() async {
    QueryBuilder<TransactionsModel> builder = TransactionRepository()
        .transactionBox
        .query(TransactionsModel_.txnDate
                .notNull()
                .and(TransactionsModel_.txnType.equals('PAYMENT'))
                .or(TransactionsModel_.txnType.equals('RECEIVE')) &
            TransactionsModel_.txnDate
                .greaterOrEqual(firstDayOfMonth().millisecondsSinceEpoch) &
            TransactionsModel_.txnDate
                .lessOrEqual(lastDayOfMonth().millisecondsSinceEpoch))
      ..order(TransactionsModel_.txnDate, flags: Order.descending);

    Query<TransactionsModel> query = builder.build();
    List<TransactionsModel> data = query.find().toList();
    query.close();

    state = AsyncValue<List<TransactionsModel>>.data(data);
  }
}
