import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/repositories/account_repository.dart';

final accountProvider = StateNotifierProvider.autoDispose
    .family<AccountState, AsyncValue<List<AccountsModel>>, int>(
        (ref, parentId) {
  return AccountState(parentId: parentId);
});

class AccountState extends StateNotifier<AsyncValue<List<AccountsModel>>> {
  final int parentId;
  AccountState({required this.parentId})
      : super(const AsyncValue<List<AccountsModel>>.loading()) {
    getAccounts(parentId);
  }

  //---GET ALL
  getAccounts(int parentId) async {
    final data = await AccountRepository().getAccounts(parentId: parentId);
    state = AsyncValue<List<AccountsModel>>.data(data);
  }

  //--CREATE

}
