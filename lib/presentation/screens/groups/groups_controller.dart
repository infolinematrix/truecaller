import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/repositories/account_repository.dart';
import 'package:truecaller/data/source/objectstore.dart';
import 'package:truecaller/objectbox.g.dart';
import 'package:truecaller/utils/functions.dart';

final accountBox = store!.objStore.box<AccountsModel>();

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

  Future<bool> create({required Map<String, dynamic> formData}) async {
    try {
      final data = AccountsModel(
        parent: 0,
        type: formData['accountType'].toString().trim(),
        name: formData['name'].toString().trim(),
        description: formData['description'].toString().trim(),
        createdOn: convertDateToLocal(DateTime.now().toString()),
        allowPayment: formData['allowPayment'],
        allowReceipt: formData['allowReceipt'],
        allowTransfer: formData['allowTransfer'],
      );

      accountBox.put(data);
      store!.objStore.awaitAsyncSubmitted();

      getGroups();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> delete({required int groupId}) async {
    try {
      QueryBuilder<AccountsModel> builder =
          accountBox.query(AccountsModel_.parent.equals(groupId));

      Query<AccountsModel> query = builder.build();
      List<AccountsModel> data = query.find().toList();

      if (data.isNotEmpty) {
        EasyLoading.showError("Can't remove! Child account exist.");
        return false;
      }
    } catch (e) {
      rethrow;
    }
    return true;
  }
}
