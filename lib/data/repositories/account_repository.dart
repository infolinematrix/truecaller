import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/source/objectstore.dart';
import 'package:truecaller/objectbox.g.dart';

class AccountRepository {
  final accountBox = store!.objStore.box<AccountsModel>();

  Future<List<AccountsModel>> getGroups() async {
    QueryBuilder<AccountsModel> builder = accountBox.query(
        AccountsModel_.name.notEquals('') & AccountsModel_.parent.equals(0))
      ..order(AccountsModel_.name, flags: Order.caseSensitive);

    Query<AccountsModel> query = builder.build();
    List<AccountsModel> data = query.find().toList();

    query.close();
    return data;
  }

  //--Bank Accounts

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
                  AccountsModel_.allowPayment.equals(true))
            ..order(AccountsModel_.name, flags: Order.caseSensitive);
          Query<AccountsModel> query = builder.build();
          data = query.find().toList();
          query.close();
        }
        break;

      case 'RECEIPT':
        {
          QueryBuilder<AccountsModel> builder = accountBox.query(
              AccountsModel_.name.notEquals('') &
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
}
