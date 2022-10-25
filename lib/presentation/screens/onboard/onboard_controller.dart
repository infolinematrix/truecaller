import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:truecaller/utils/index.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class InitialDataModel {
  final bool isLoggedin;

  InitialDataModel({
    required this.isLoggedin,
  });
}

final inttAppProvider =
    FutureProvider.autoDispose<InitialDataModel>((ref) async {
  final isLoggedin = await ref.watch(isLoggedInProvider);

  return InitialDataModel(
    isLoggedin: isLoggedin,
  );
});

// -- IS LOGGEDIN
final isLoggedInProvider = Provider.autoDispose((ref) async {
  if (auth.currentUser == null) {
    // signed in
    auth.signInAnonymously().then((result) {
      final User user = result.user!;
      log(user);
    });

    return true;
  } else {
    return true;
  }
});
