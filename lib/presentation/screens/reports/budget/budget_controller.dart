import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/models/transactions_model.dart';
import 'package:truecaller/data/repositories/account_repository.dart';
import 'package:truecaller/data/repositories/transaction_repository.dart';
import 'package:truecaller/objectbox.g.dart';
import 'package:truecaller/utils/index.dart';

final budgetReportProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  try {
    //--Accounts
    QueryBuilder<AccountsModel> accountsBuilder = AccountRepository()
        .accountBox
        .query(AccountsModel_.name
            .notNull()
            .and(AccountsModel_.hasChild.equals(false))
            .and(AccountsModel_.budget.greaterThan(0)));

    Query<AccountsModel> accountsQuery = accountsBuilder.build();
    List<AccountsModel> accountsList = accountsQuery.find().toList();
    accountsQuery.close();

    List<Map<String, dynamic>> data = [];
    for (var account in accountsList) {
      double balance = getBalance(account.id);

      data.addAll([
        {
          'accountName': account.name,
          'description': account.description,
          'budget': account.budget,
          'spentAmount': balance
        }
      ]);
    }

    return data;
  } catch (e) {
    rethrow;
  }
});

double getBalance(int accountId) {
  QueryBuilder<TransactionsModel> txnBuilder = TransactionRepository()
      .transactionBox
      .query(TransactionsModel_.account
              .equals(accountId)
              .and(TransactionsModel_.txnType.equals('PAYMENT')) &
          TransactionsModel_.txnDate
              .greaterOrEqual(firstDayCurrentMonth.millisecondsSinceEpoch) &
          TransactionsModel_.txnDate
              .lessOrEqual(lastDayCurrentMonth.millisecondsSinceEpoch));

  Query<TransactionsModel> txnQuery = txnBuilder.build();
  List<TransactionsModel> txnList = txnQuery.find().toList();

  double paymentAmt = 0.0;
  // double receiveAmt = 0.0;
  double balanceAmt = 0.0;

  for (var txn in txnList) {
    if (txn.txnType == 'PAYMENT') paymentAmt += txn.amountDr;
    // if (txn.txnType == 'RECEIVE') receiveAmt += txn.amountCr;
  }

  // balanceAmt = receiveAmt - paymentAmt;
  balanceAmt = paymentAmt;

  return balanceAmt;
}
