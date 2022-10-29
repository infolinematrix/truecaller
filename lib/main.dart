import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:objectbox/objectbox.dart';
import 'package:truecaller/data/source/objectstore.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'presentation/screens/error.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      if (kReleaseMode) exit(1);
    };

    /**
     * Initialize App
     */
    await initApp();

    runApp(
      const ProviderScope(child: MyApp()),
    );

    // Transparent status bar
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }, (Object error, StackTrace stack) {
    ErrorScreen(msg: error.toString());
  });
}

Future<void> initApp() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  //--ObjectBox
  store = await Database.create();

  if (kDebugMode) {
    if (Admin.isAvailable()) {
      admin = Admin(store!.objStore);
    }
  }
}
