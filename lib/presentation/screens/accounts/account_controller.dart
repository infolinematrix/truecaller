import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/models/transactions_model.dart';
import 'package:truecaller/data/repositories/account_repository.dart';
import 'package:truecaller/data/source/objectstore.dart';
import 'package:truecaller/objectbox.g.dart';
import 'package:truecaller/utils/functions.dart';

final hasChildProvider = StateProvider.autoDispose<bool>((ref) => false);
final hasBudget = StateProvider.autoDispose<bool>((ref) => false);
final hasOpeningBanlance = StateProvider.autoDispose<bool>((ref) => false);

final accountBox = store!.objStore.box<AccountsModel>();
final transactionBox = store!.objStore.box<TransactionsModel>();

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
        budget: formData['hasBudget'] == true
            ? double.parse(formData['budget'].toString()).toDouble()
            : 0.0,
        openingBalance: formData['hasOpeningBalance'] == true
            ? double.parse(formData['openingBalance'].toString()).toDouble()
            : 0.0,
        isActive: formData['isActive'],
        isSystem: false,
      );

      accountBox.put(data);
      store!.objStore.awaitAsyncSubmitted();

      getAccounts(parent.id);

      return true;
    } catch (e) {
      return false;
    }
  }

  //--Delete
  Future delete({required int parentId, required int id}) async {
    try {
      QueryBuilder<AccountsModel> builder =
          accountBox.query(AccountsModel_.parent.equals(id));

      Query<AccountsModel> query = builder.build();
      List<AccountsModel> data = query.find().toList();
      query.close();

      if (data.isNotEmpty) {
        EasyLoading.showError("Can't remove! Child account exist.");
        return false;
      } else {
        //--DELETE ALL TRANSACTIONS
        QueryBuilder<TransactionsModel> builder =
            transactionBox.query(TransactionsModel_.account.equals(id));
        Query<TransactionsModel> query = builder.build();

        List<TransactionsModel> data = query.find().toList();

        for (var element in data) {
          transactionBox.remove(element.id);
        }
        query.close();

        accountBox.remove(id);
        getAccounts(parentId);

        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  
}
