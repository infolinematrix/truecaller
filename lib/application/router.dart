import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:truecaller/presentation/screens/accounts/account_create_screen.dart';
import 'package:truecaller/presentation/screens/accounts/account_edit_screen.dart';
import 'package:truecaller/presentation/screens/accounts/account_search.dart';
import 'package:truecaller/presentation/screens/accounts/accounts_screen.dart';
import 'package:truecaller/presentation/screens/accounts/statement_screen.dart';
import 'package:truecaller/presentation/screens/groups/group_create_screen.dart';
import 'package:truecaller/presentation/screens/groups/group_edit_screen.dart';
import 'package:truecaller/presentation/screens/groups/groups_screen.dart';
import 'package:truecaller/presentation/screens/home/home_screen.dart';
import 'package:truecaller/presentation/screens/settings/settings_screen.dart';
import 'package:truecaller/presentation/screens/transactions/payment_screen.dart';
import 'package:truecaller/presentation/screens/transactions/receipt_screen.dart';
import 'package:truecaller/presentation/screens/transactions/transfer_screen.dart';

import '../presentation/screens/error.dart';
import '../presentation/screens/reports/report_screen.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    // GoRoute(
    //   path: '/',
    //   name: 'ONBOARD',
    //   pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
    //     context: context,
    //     state: state,
    //     child: const OnboardScreen(),
    //   ),
    // ),
    GoRoute(
      path: '/',
      name: 'HOME',
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
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const GroupsScreen(),
            ),
        routes: [
          GoRoute(
            path: 'create',
            name: "GROUPS/CREATE",
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const GroupCreateScreen(),
            ),
          ),
          GoRoute(
            path: 'edit',
            name: "GROUPS/EDIT",
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const GroupEditScreen(),
            ),
          ),
        ]),
    GoRoute(
        path: '/accounts',
        name: "ACCOUNTS",
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const AccountsScreen(),
            ),
        routes: [
          GoRoute(
            path: 'accounts-search',
            name: 'ACCOUNTS/SEARCH',
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const AccountSearchScreen(),
            ),
          ),
          GoRoute(
            path: 'create',
            name: 'ACCOUNTS/CREATE',
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const AccountCreateScreen(),
            ),
          ),
          GoRoute(
            path: 'edit',
            name: 'ACCOUNTS/EDIT',
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const AccountEditScreen(),
            ),
          ),
        ]),
    GoRoute(
        path: '/statement/:id/:name',
        name: "STATEMENT",
        pageBuilder: (context, state) {
          String name = state.params['name']!;
          int id = int.parse(state.params['id']!);
          return buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: AccountStatementScreen(
              name: name,
              id: id,
            ),
          );
        }),
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
    GoRoute(
      path: '/payment',
      name: 'PAYMENT',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return buildPageWithDefaultTransition(
            context: context, state: state, child: const PaymentScreen());
      },
    ),
    GoRoute(
      path: '/receipt',
      name: 'RECEIPT',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return buildPageWithDefaultTransition<void>(
            context: context, state: state, child: const ReceiptScreen());
      },
    ),
    GoRoute(
      path: '/transfer',
      name: 'TRANSFER',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return buildPageWithDefaultTransition<void>(
            context: context, state: state, child: const TransferScreen());
      },
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
        FadeTransition(opacity: animation, child: child),
    // SlideTransition(
    //     position: Tween(
    //             begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
    //         .animate(animation),
    //     child: child),
  );
}
