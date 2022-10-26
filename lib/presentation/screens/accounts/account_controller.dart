import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/repositories/account_repository.dart';
import 'package:truecaller/data/source/objectstore.dart';
import 'package:truecaller/utils/functions.dart';

final hasChildProvider = StateProvider.autoDispose<bool>((ref) => false);
final hasBudget = StateProvider.autoDispose<bool>((ref) => false);
final hasOpeningBanlance = StateProvider.autoDispose<bool>((ref) => false);

final accountBox = store!.objStore.box<AccountsModel>();

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
  Future<bool> create(
      {required AccountsModel parent,
      required Map<String, dynamic> formData}) async {
    try {
      final data = AccountsModel(
        parent: parent.id,
        type: parent.type.toString().trim(),
        name: formData['name'].toString().trim(),
        description: formData['description'].toString().trim(),
        createdOn: convertDateToLocal(DateTime.now().toString()),
        allowPayment: formData['allowPayment'],
        allowReceipt: formData['allowReceipt'],
        allowTransfer: formData['allowTransfer'],
        hasChild: formData['hasChild'],
        budget: formData['hasBudget'] == true ? formData['budget'] : 0.0,
        openingBalance: formData['hasOpeningBalance'] == true
            ? formData['openingBalance']
            : 0.0,
        isActive: formData['isActive'],
        isSystem: false,
      );

      // accountBox.put(data);
      // store!.objStore.awaitAsyncSubmitted();
      print(data);

      getAccounts(parent.id);

      return true;
    } catch (e) {
      return false;
    }
  }
}
