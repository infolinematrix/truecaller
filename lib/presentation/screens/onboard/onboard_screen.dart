import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truecaller/presentation/screens/home/home_screen.dart';
import 'package:truecaller/presentation/screens/settings/settings_screen.dart';
import 'package:truecaller/presentation/screens/splash/splash_screen.dart';

import 'onboard_controller.dart';

class OnboardScreen extends ConsumerWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(inttAppProvider);
    return initialize.when(
      error: (error, stackTrace) => ErrorWidget(error.toString()),
      loading: () => const SplashScreen(),
      data: (data) {
        if (data.isLoggedin == false) {
          return const SettingsScreen();
        }
        if (data.settings.isEmpty) {
          return const SettingsScreen();
        }

        // if (data.isAuth == false) {
        //   exit(0);
        // }

        return const HomeScreen();
      },
    );
  }
}
