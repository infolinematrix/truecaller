import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/source/objectstore.dart';

final accountBox = store!.objStore.box<AccountsModel>();

final hasOpeningBanlance = StateProvider.autoDispose<bool>((ref) => true);

final createBankAccountProvider = FutureProvider.family
    .autoDispose<bool, Map<String, dynamic>>((ref, formData) async {
  try {
    final data = AccountsModel(
      parent: 1,
      type: "BANK",
      name: formData['name'].toString().trim(),
      description: formData['description'].toString().trim(),
      createdOn: DateTime.now().toLocal(),
      allowTransfer: true,
      allowPayment: false,
      allowReceipt: false,
      hasChild: false,
      openingBalance: formData['hasOpeningBalance'] == true
          ? double.parse(formData['openingBalance'].toString()).toDouble()
          : 0.0,
      isActive: true,
      isSystem: false,
    );

    await accountBox.putAsync(data);
    store!.objStore.awaitAsyncSubmitted();

    return true;
  } catch (e) {
    rethrow;
  }
});
