import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:objectbox/objectbox.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/data/models/scroll_model.dart';
import 'package:truecaller/data/models/settings_model.dart';
import 'package:truecaller/data/source/objectstore.dart';
import 'package:truecaller/presentation/screens/error.dart';
import 'package:truecaller/utils/functions.dart';

final settingBox = store!.objStore.box<SettingsModel>();
final scrollBox = store!.objStore.box<ScrollModel>();
final accountBox = store!.objStore.box<AccountsModel>();
final FirebaseAuth auth = FirebaseAuth.instance;

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
    });

    //--Store data to Firebase user collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Map<String, dynamic> fbData = {};

    if (auth.currentUser != null) {
      for (var element in formData.entries) {
        if (element.key == 'name') {
          fbData.addAll({'name': element.value.toString()});
        }
        if (element.key == 'currency') {
          fbData.addAll({'currency': element.value.toString()});
        }
      }
      fbData.addAll({'createdAt': DateTime.now().toLocal().toString()});
      fbData.addAll({'user': auth.currentUser!.uid.toString()});
      fbData.addAll({'isActive': true});

      var ip = await getIp();

      //--FCM TOKEN AND SUBSRIBE
      var fcmToken = await getFCMToken();

      fbData.addAll({'ipAddress': ip});
      fbData.addAll({'fcmToken': fcmToken});

      await users.add(fbData);

      //--Subsribe Firebase Messaging topic to all
      await subscribeFirebaseMessagingTopic(topic: 'All');
    }

    return true;
  } catch (e) {
    return ErrorScreen(msg: e.toString());
  }
});
