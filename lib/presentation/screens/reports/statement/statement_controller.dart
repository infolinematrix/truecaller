import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/repositories/account_repository.dart';
import 'package:truecaller/objectbox.g.dart';

//---ACCOUNTS
final searchStringProvider = StateProvider.autoDispose<String>((ref) => '');

final accountNotifierProvider = StateNotifierProvider.autoDispose<AccountsState,
    AsyncValue<List<AccountsModel>>>((ref) {
  return AccountsState(ref);
});

class AccountsState extends StateNotifier<AsyncValue<List<AccountsModel>>> {
  final Ref ref;
  AccountsState(this.ref)
      : super(const AsyncValue<List<AccountsModel>>.loading()) {
    getAccounts();
  }

  //---GET ALL
  getAccounts() async {
    QueryBuilder<AccountsModel> builder = AccountRepository().accountBox.query(
          AccountsModel_.name.notEquals('') &
              AccountsModel_.parent.notEquals(0) &
              AccountsModel_.type.notEquals('BANK'),
        )..order(AccountsModel_.name, flags: Order.caseSensitive);

    Query<AccountsModel> query = builder.build();
    List<AccountsModel> data = query.find().toList();
    query.close();

    state = AsyncValue<List<AccountsModel>>.data(data);
  }

  search() async {
    String searchStr = ref.read(searchStringProvider);
    if (searchStr != '') {
      QueryBuilder<AccountsModel> builder =
          AccountRepository().accountBox.query(
                AccountsModel_.name.notEquals('') &
                    AccountsModel_.hasChild.equals(false) &
                    AccountsModel_.type.notEquals('BANK') &
                    AccountsModel_.type.notEquals('CASH') &
                    AccountsModel_.name.startsWith(searchStr),
              )..order(AccountsModel_.name, flags: Order.caseSensitive);

      Query<AccountsModel> query = builder.build();
      List<AccountsModel> data = query.find().toList();
      query.close();
      state = AsyncValue<List<AccountsModel>>.data(data);
    } else {
      QueryBuilder<AccountsModel> builder = AccountRepository()
          .accountBox
          .query(AccountsModel_.name.notEquals('') &
              AccountsModel_.type.notEquals('BANK') &
              AccountsModel_.hasChild.equals(false))
        ..order(AccountsModel_.name, flags: Order.caseSensitive);

      Query<AccountsModel> query = builder.build();
      List<AccountsModel> data = query.find().toList();
      query.close();
      state = AsyncValue<List<AccountsModel>>.data(data);
    }
  }
}
