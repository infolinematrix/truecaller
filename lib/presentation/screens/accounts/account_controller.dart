import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/models/transactions_model.dart';
import 'package:truecaller/data/repositories/account_repository.dart';
import 'package:truecaller/data/source/objectstore.dart';
import 'package:truecaller/objectbox.g.dart';
import 'package:truecaller/presentation/screens/transactions/transaction_controller.dart';
import 'package:truecaller/utils/functions.dart';

final hasChildProvider = StateProvider.autoDispose<bool>((ref) => false);
final hasBudget = StateProvider.autoDispose<bool>((ref) => false);
final hasOpeningBanlance = StateProvider.autoDispose<bool>((ref) => false);

final accountBox = store!.objStore.box<AccountsModel>();

final getAccountProvider = FutureProvider.autoDispose
    .family<AccountsModel, int>((ref, parentId) async {
  try {
    var data = accountBox.get(parentId);
    return data!;
  } catch (e) {
    rethrow;
  }
});

final accountProvider = StateNotifierProvider.autoDispose
    .family<AccountState, AsyncValue<List<AccountsModel>>, int>(
        (ref, parentId) {
  return AccountState(parentId: parentId);
});

class AccountState extends StateNotifier<AsyncValue<List<AccountsModel>>> {
  final int parentId;
  AccountState({required this.parentId})
      : super(const AsyncValue<List<AccountsModel>>.loading()) {
    getAccounts();
  }

  //---GET ALL
  getAccounts() async {
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

      getAccounts();

      return true;
    } catch (e) {
      return false;
    }
  }

  //--Delete
  Future delete({required int id}) async {
    try {
      //--Check there is child account exist
      QueryBuilder<AccountsModel> builder =
          accountBox.query(AccountsModel_.parent.equals(id));

      Query<AccountsModel> query = builder.build();
      List<AccountsModel> data = query.find().toList();

      if (data.isNotEmpty) {
        EasyLoading.showError("Can't remove! Child account exist.");
        return false;
      }

      Query<TransactionsModel> txnQuery =
          transactionBox.query(TransactionsModel_.account.equals(id)).build();
      List<TransactionsModel> txnData = txnQuery.find().toList();

      //-- Delete all transactions of this account
      for (var element in txnData) {
        transactionBox.remove(element.id);
      }

      accountBox.remove(id);
      getAccounts();

      return true;
    } catch (e) {
      rethrow;
    }
  }

  //--UPDATE
  Future<bool> update(
      {required AccountsModel account,
      required Map<String, dynamic> formData}) async {
    try {
      // account.hasChild = formData['hasChild'];
      account.name = formData['name'].toString().trim();
      account.description = formData['description'].toString().trim();
      account.budget = formData['hasBudget'] == true
          ? double.parse(formData['budget'].toString()).toDouble()
          : 0.0;
      account.openingBalance = formData['hasOpeningBalance'] == true
          ? double.parse(formData['openingBalance'].toString()).toDouble()
          : 0.0;
      account.allowPayment = formData['allowPayment'];
      account.allowReceipt = formData['allowReceipt'];
      account.allowTransfer = formData['allowTransfer'];

      account.isActive = formData['isActive'];

      accountBox.putAsync(account);
      store!.objStore.awaitAsyncSubmitted();

      getAccounts();
      return true;
    } catch (e) {
      rethrow;
    }
  }
}

//----- ACCOUNT SEARCH PROVIDER ----------//

final searchStringProvider = StateProvider.autoDispose<String>((ref) => '');

final accountSearchProvider = StateNotifierProvider.autoDispose<
    AccountSearchState, AsyncValue<List<AccountsModel>>>((ref) {
  return AccountSearchState(ref);
});

class AccountSearchState
    extends StateNotifier<AsyncValue<List<AccountsModel>>> {
  final Ref ref;
  AccountSearchState(this.ref)
      : super(const AsyncValue<List<AccountsModel>>.loading()) {
    getAccounts();
  }

  //---GET ALL
  getAccounts() async {
    String searchStr = ref.read(searchStringProvider);
    final data = await AccountRepository().getSearchedAccounts(searchStr);
    state = AsyncValue<List<AccountsModel>>.data(data);
  }

  search() async {
    String searchStr = ref.read(searchStringProvider);
    final data = await AccountRepository().getSearchedAccounts(searchStr);
    state = AsyncValue<List<AccountsModel>>.data(data);
  }
}
//--- END OF ACCOUNT SEARCH --------------------//


