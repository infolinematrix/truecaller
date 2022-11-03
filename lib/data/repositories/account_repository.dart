import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/models/transactions_model.dart';
import 'package:truecaller/data/source/objectstore.dart';
import 'package:truecaller/objectbox.g.dart';

class AccountRepository {
  final accountBox = store!.objStore.box<AccountsModel>();
  final transactionBox = store!.objStore.box<TransactionsModel>();

  Future<List<AccountsModel>> getGroups() async {
    QueryBuilder<AccountsModel> builder = accountBox.query(
        AccountsModel_.name.notEquals('') & AccountsModel_.parent.equals(0))
      ..order(AccountsModel_.name, flags: Order.caseSensitive);

    Query<AccountsModel> query = builder.build();
    List<AccountsModel> data = query.find().toList();

    query.close();
    return data;
  }

  //--All Accounts
  Future<List<AccountsModel>> all() async {
    QueryBuilder<AccountsModel> builder = accountBox.query(
        AccountsModel_.name.notEquals('') &
            AccountsModel_.parent.notEquals(0) &
            AccountsModel_.hasChild.equals(false))
      ..order(AccountsModel_.name, flags: Order.caseSensitive);

    Query<AccountsModel> query = builder.build();
    List<AccountsModel> data = query.find().toList();

    query.close();
    return data;
  }

  Future<List<AccountsModel>> accountByType({required String type}) async {
    QueryBuilder<AccountsModel> builder = accountBox.query(
        AccountsModel_.name.notEquals('') &
            AccountsModel_.parent.notEquals(0) &
            AccountsModel_.type.equals(type))
      ..order(AccountsModel_.name, flags: Order.caseSensitive);

    Query<AccountsModel> query = builder.build();
    List<AccountsModel> data = query.find().toList();

    query.close();
    return data;
  }

  Future<List<AccountsModel>> getAccounts({required int parentId}) async {
    QueryBuilder<AccountsModel> builder = accountBox.query(
        AccountsModel_.name.notEquals('') &
            AccountsModel_.parent.equals(parentId))
      ..order(AccountsModel_.name, flags: Order.caseSensitive);

    Query<AccountsModel> query = builder.build();
    List<AccountsModel> data = query.find().toList();

    query.close();
    return data;
  }

  Future<List<AccountsModel>> getAccountsByAllowedType(
      {required String allowedType}) async {
    List<AccountsModel> data = <AccountsModel>[];

    switch (allowedType) {
      case 'PAYMENT':
        {
          QueryBuilder<AccountsModel> builder = accountBox.query(
              AccountsModel_.name.notEquals('') &
                  AccountsModel_.hasChild.equals(false) &
                  AccountsModel_.parent.notEquals(0) &
                  AccountsModel_.allowPayment.equals(true))
            ..order(AccountsModel_.name, flags: Order.caseSensitive);
          Query<AccountsModel> query = builder.build();
          data = query.find().toList();
          query.close();
        }
        break;

      case 'RECEIVE':
        {
          QueryBuilder<AccountsModel> builder = accountBox.query(
              AccountsModel_.name.notEquals('') &
                  AccountsModel_.hasChild.equals(false) &
                  AccountsModel_.parent.notEquals(0) &
                  AccountsModel_.allowReceipt.equals(true))
            ..order(AccountsModel_.name, flags: Order.caseSensitive);
          Query<AccountsModel> query = builder.build();
          data = query.find().toList();
          query.close();
        }
        break;

      case 'TRANSFER':
        {
          QueryBuilder<AccountsModel> builder = accountBox.query(
              AccountsModel_.name.notEquals('') &
                  AccountsModel_.hasChild.equals(false) &
                  AccountsModel_.parent.notEquals(0) &
                  AccountsModel_.allowTransfer.equals(true))
            ..order(AccountsModel_.name, flags: Order.caseSensitive);
          Query<AccountsModel> query = builder.build();
          data = query.find().toList();
          query.close();
        }
        break;
    }

    return data;
  }

  //-- Account wise Receive & Payment with date range => return Map{}
  Future<Map<String, dynamic>> accountSummary(
      {required int accountNo,
      required DateTime startDate,
      required DateTime endtDate}) async {
    QueryBuilder<TransactionsModel> builder = transactionBox.query(
      TransactionsModel_.account.equals(accountNo) &
          TransactionsModel_.txnDate
              .greaterOrEqual(startDate.millisecondsSinceEpoch) &
          TransactionsModel_.txnDate
              .lessOrEqual(endtDate.microsecondsSinceEpoch),
    );
    Query<TransactionsModel> query = builder.build();

    double sumAmountDr = query.property(TransactionsModel_.amountDr).sum();
    double sumAmountCr = query.property(TransactionsModel_.amountCr).sum();

    final data = {
      'sum_debit': sumAmountDr,
      'sum_credit': sumAmountCr,
    };
    query.close();

    return data;
  }
}
