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
}
