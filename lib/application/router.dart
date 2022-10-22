import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:truecaller/presentation/screens/accounts/accounts_screen.dart';
import 'package:truecaller/presentation/screens/groups/groups_screen.dart';
import 'package:truecaller/presentation/screens/home/home_screen.dart';
import 'package:truecaller/presentation/screens/settings/settings_screen.dart';

import '../presentation/screens/error.dart';
import '../presentation/screens/reports/report_screen.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/reports',
      name: 'report',
      builder: (BuildContext context, GoRouterState state) {
        return const ReportsScreen();
      },
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: const ReportsScreen(),
      ),
    ),
    GoRoute(
      path: '/groups',
      name: "groups",
      builder: (BuildContext context, GoRouterState state) {
        return const GroupsScreen();
      },
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: const GroupsScreen(),
      ),
    ),
    GoRoute(
      path: '/accounts',
      name: "ACCOUNTS",
      builder: (BuildContext context, GoRouterState state) {
        return const AccountsScreen();
      },
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: const AccountsScreen(),
      ),
    ),
    GoRoute(
      path: '/settings',
      name: "SETTINGS",
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsScreen();
      },
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: const SettingsScreen(),
      ),
    ),
  ],

  //--ERROR SCREEN
  errorBuilder: (context, state) => ErrorScreen(msg: state.error.toString()),
);

//--TRANSITION
CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        // FadeTransition(opacity: animation, child: child),
        SlideTransition(
            position: Tween(
                    begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                .animate(animation),
            child: child),
  );
}
