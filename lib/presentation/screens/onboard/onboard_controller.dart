import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:truecaller/data/models/settings_model.dart';
import 'package:truecaller/data/repositories/settings_repository.dart';
import 'package:truecaller/utils/local_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class InitialDataModel {
  final bool isLoggedin;
  final List<SettingsModel> settings;
  final bool isAuth;

  InitialDataModel({
    required this.isLoggedin,
    required this.settings,
    required this.isAuth,
  });
}

final inttAppProvider =
    FutureProvider.autoDispose<InitialDataModel>((ref) async {
  final isLoggedin = await ref.watch(isLoggedInProvider);
  final settings = await ref.watch(getSettingsProvider.future);
  final isAuth = await ref.watch(localAuthProvider.future);

  return InitialDataModel(
    isLoggedin: isLoggedin,
    settings: settings,
    isAuth: isAuth,
  );
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

//--Local Auth
//TODO: Enable when ready
final localAuthProvider = FutureProvider<bool>((ref) async {
  final auth = LocalAuth();
  await auth.authenticate();

  return auth.isAuthorised;
});
