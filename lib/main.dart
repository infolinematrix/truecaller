import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:truecaller/theme/app_theme.dart';

import 'application/router.dart';
import 'presentation/screens/error.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      if (kReleaseMode) exit(1);
    };

    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812 - 44 - 34),
      minTextAdapt: false,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          title: 'Flutter Demo',
          localizationsDelegates: const [FormBuilderLocalizations.delegate],
          supportedLocales: FormBuilderLocalizations.delegate.supportedLocales,
        );
      },
    );
  }
}
