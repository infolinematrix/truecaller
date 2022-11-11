import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/data/models/transactions_model.dart';
import 'package:truecaller/data/repositories/transaction_repository.dart';
import 'package:truecaller/objectbox.g.dart';
import 'package:truecaller/utils/index.dart';

final bankBookProvider = StateNotifierProvider.autoDispose<
    BankBookStateNotifier, AsyncValue<List<TransactionsModel>>>((ref) {
  return BankBookStateNotifier(ref);
});

class BankBookStateNotifier
    extends StateNotifier<AsyncValue<List<TransactionsModel>>> {
  final Ref ref;
  BankBookStateNotifier(this.ref)
      : super(const AsyncValue<List<TransactionsModel>>.loading()) {
    getTransactions();
  }

  getTransactions() async {
    QueryBuilder<TransactionsModel> builder = TransactionRepository()
        .transactionBox
        .query(TransactionsModel_.txnDate.notNull() &
            TransactionsModel_.txnMode.equals('BANK') &
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
