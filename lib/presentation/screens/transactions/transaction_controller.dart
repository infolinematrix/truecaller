import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/models/scroll_model.dart';
import 'package:truecaller/data/models/transactions_model.dart';
import 'package:truecaller/data/repositories/account_repository.dart';
import 'package:truecaller/data/source/objectstore.dart';

final accountBox = store!.objStore.box<AccountsModel>();
final transactionBox = store!.objStore.box<TransactionsModel>();
final scrollBox = store!.objStore.box<ScrollModel>();

//--Get Scroll
Future<int> getScroll() async {
  try {
    var scroll = scrollBox.get(1);

    if (scroll != null) {
      return scroll.slno!;
    } else {
      return 0;
    }
  } catch (e) {
    return 0;
  }
}

//--Update Scroll
Future updateScroll() async {
  var scroll = scrollBox.get(1);

  if (scroll == null) {
    var newNo = ScrollModel(slno: 1);
    scrollBox.put(newNo);
  } else {
    scroll.slno = scroll.slno! + 1;
    scrollBox.put(scroll);
  }
}

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

/// PAYMENT ENTRY
final doPayment = FutureProvider.family
    .autoDispose<bool, Map<String, dynamic>>((ref, formData) async {
  try {
    int id = 0;
    var scrollNo = await getScroll();

    if (formData['mode'] == 'CASH') {
      final data = TransactionsModel(
        account: formData['account'],
        accountName: formData['name'],
        narration: 'By Cash',
        amountDr: double.parse(formData['amount'].toString()).toDouble(),
        amountCr: double.parse(formData['amount'].toString()).toDouble(),
        txnMode: formData['mode'].toString().trim(),
        modeAccount: 0,
        txnType: 'PAYMENT',
        scrollNo: scrollNo + 1,
        txnDate: DateTime.now().toLocal(),
        createdOn: DateTime.now().toLocal(),
        description: formData['description'] ?? 'No description',
      );

      id = await transactionBox.putAsync(data);
    }

    if (formData['mode'] == 'BANK') {
      AccountsModel? bank =
          AccountRepository().accountBox.get(formData['bank_account']);

      final data = TransactionsModel(
        account: formData['account'],
        accountName: formData['name'],
        narration: 'By Bank',
        amountDr: double.parse(formData['amount'].toString()).toDouble(),
        amountCr: double.parse(formData['amount'].toString()).toDouble(),
        txnMode: formData['mode'].toString().trim(),
        modeAccount: bank!.id,
        txnType: 'PAYMENT',
        scrollNo: scrollNo + 1,
        txnDate: DateTime.now().toLocal(),
        createdOn: DateTime.now().toLocal(),
        description: formData['description'] ?? 'No description',
      );

      id = await transactionBox.putAsync(data);
    }

    if (id != 0) {
      await updateScroll();
      store!.objStore.awaitAsyncSubmitted();

      return true;
    }
  } catch (e) {
    rethrow;
  }

  return false;
});

/// RECEIVE ENTRY
final doReceipt = FutureProvider.family
    .autoDispose<bool, Map<String, dynamic>>((ref, formData) async {
  try {
    int id = 0;
    var scrollNo = await getScroll();

    if (formData['mode'] == 'CASH') {
      final data = TransactionsModel(
        account: formData['account'],
        accountName: formData['name'],
        narration: 'By Cash',
        amountDr: double.parse(formData['amount'].toString()).toDouble(),
        amountCr: double.parse(formData['amount'].toString()).toDouble(),
        txnMode: formData['mode'].toString().trim(),
        modeAccount: 0,
        txnType: 'RECEIVE',
        scrollNo: scrollNo + 1,
        txnDate: DateTime.now().toLocal(),
        createdOn: DateTime.now().toLocal(),
        description: formData['description'] ?? 'No description',
      );

      id = await transactionBox.putAsync(data);
    }

    if (formData['mode'] == 'BANK') {
      AccountsModel? bank =
          AccountRepository().accountBox.get(formData['bank_account']);

      final data = TransactionsModel(
        account: formData['account'],
        accountName: formData['name'],
        narration: 'By Bank',
        amountDr: double.parse(formData['amount'].toString()).toDouble(),
        amountCr: double.parse(formData['amount'].toString()).toDouble(),
        txnMode: formData['mode'].toString().trim(),
        modeAccount: bank!.id,
        txnType: 'RECEIVE',
        scrollNo: scrollNo + 1,
        txnDate: DateTime.now().toLocal(),
        createdOn: DateTime.now().toLocal(),
        description: formData['description'] ?? 'No description',
      );

      id = await transactionBox.putAsync(data);
    }

    if (id != 0) {
      await updateScroll();
      store!.objStore.awaitAsyncSubmitted();

      return true;
    }
  } catch (e) {
    rethrow;
  }

  return false;
});
