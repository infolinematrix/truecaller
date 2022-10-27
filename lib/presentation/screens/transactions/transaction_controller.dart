import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/repositories/account_repository.dart';

final txnModeProvider = StateProvider.autoDispose<String>((ref) => 'CASH');

//--Load Bank accounts
final banksProvider = FutureProvider.autoDispose((ref) async {
  return await AccountRepository().accountByType(type: "BANK");
});

final transactionAccountProvider = StateNotifierProvider.autoDispose
    .family<AccountState, AsyncValue<List<AccountsModel>>, String>(
        (ref, allowedType) {
  return AccountState(allowedType: allowedType);
});

class AccountState extends StateNotifier<AsyncValue<List<AccountsModel>>> {
  final String allowedType;
  AccountState({required this.allowedType})
      : super(const AsyncValue<List<AccountsModel>>.loading()) {
    getAccounts(allowedType);
  }

  //---GET ALL
  getAccounts(String allowedType) async {
    final data = await AccountRepository()
        .getAccountsByAllowedType(allowedType: allowedType);
    state = AsyncValue<List<AccountsModel>>.data(data);
  }
}
