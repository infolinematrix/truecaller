import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/repositories/account_repository.dart';

// final accountGroupProvider = StateNotifierProvider<AccountGroupState>((ref) {
//   return
// });

final accountGroupProvider = StateNotifierProvider.autoDispose<
    AccountGroupState, AsyncValue<List<AccountsModel>>>((ref) {
  return AccountGroupState();
});

class AccountGroupState extends StateNotifier<AsyncValue<List<AccountsModel>>> {
  AccountGroupState() : super(const AsyncValue<List<AccountsModel>>.loading()) {
    getGroups();
  }

  getGroups() async {
    final data = await AccountRepository().getGroups();
    state = AsyncValue<List<AccountsModel>>.data(data);
  }
}
