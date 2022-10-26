import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:truecaller/data/models/settings_model.dart';

import 'package:truecaller/data/repositories/settings_repository.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class InitialDataModel {
  final bool isLoggedin;
  final List<SettingsModel> settings;

  InitialDataModel({required this.isLoggedin, required this.settings});
}

final inttAppProvider =
    FutureProvider.autoDispose<InitialDataModel>((ref) async {
  final isLoggedin = await ref.watch(isLoggedInProvider);
  final settings = await ref.watch(getSettingsProvider.future);

  return InitialDataModel(isLoggedin: isLoggedin, settings: settings);
});

// -- IS LOGGEDIN
final isLoggedInProvider = Provider.autoDispose((ref) async {
  if (auth.currentUser == null) {
    await auth.signInAnonymously().then((result) {
      final User user = result.user!;
    });

    return true;
  } else {
    return true;
  }
});

//-- IS SETTINGS EXIST
final getSettingsProvider = FutureProvider((ref) async {
  final data = await SettingsRepository().getAll();
  return data;
});
