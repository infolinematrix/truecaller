import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:objectbox/objectbox.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/models/scroll_model.dart';
import 'package:truecaller/data/models/settings_model.dart';
import 'package:truecaller/data/source/objectstore.dart';
import 'package:truecaller/presentation/screens/error.dart';

final settingBox = store!.objStore.box<SettingsModel>();
final scrollBox = store!.objStore.box<ScrollModel>();
final accountBox = store!.objStore.box<AccountsModel>();

final createSettings = FutureProvider.autoDispose
    .family((ref, Map<String, dynamic> formData) async {
  try {
    store!.objStore.runInTransaction(TxMode.write, () {
      /**
    * Settings
    */
      for (var element in formData.entries) {
        if (element.key != 'accept_terms') {
          settingBox.put(
              SettingsModel(key: element.key, value: element.value.toString()));
        }
      }

      /**
     * Scroll No
     */
      ScrollModel scroll = ScrollModel(slno: 0);
      scrollBox.put(scroll);

      /**
     * Groups
     */
      List<AccountsModel> groups = [
        AccountsModel(
          parent: 0,
          name: 'Bank Accounts',
          type: 'BANK',
          isSystem: true,
          hasChild: true,
          isActive: true,
          description: 'All Bank accounts',
          createdOn: DateTime.now().toLocal(),
        ),
      ];

      accountBox.putMany(groups);
      // store!.objStore.awaitAsyncSubmitted();

      /**
     * Accounts
     */
    });

    store!.objStore.close();

    return true;
  } catch (e) {
    return ErrorScreen(msg: e.toString());
  }
});
