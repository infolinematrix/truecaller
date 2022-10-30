import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:truecaller/data/models/account_mode.dart';
import 'package:truecaller/presentation/screens/accounts/account_create_screen.dart';
import 'package:truecaller/presentation/screens/accounts/account_edit_screen.dart';
import 'package:truecaller/presentation/screens/accounts/account_search.dart';
import 'package:truecaller/presentation/screens/accounts/accounts_screen.dart';
import 'package:truecaller/presentation/screens/accounts/statement_screen.dart';
import 'package:truecaller/presentation/screens/groups/group_create_screen.dart';
import 'package:truecaller/presentation/screens/groups/group_edit_screen.dart';
import 'package:truecaller/presentation/screens/groups/groups_screen.dart';
import 'package:truecaller/presentation/screens/home/home_screen.dart';
import 'package:truecaller/presentation/screens/onboard/onboard_screen.dart';
import 'package:truecaller/presentation/screens/settings/bank_account_screen.dart';
import 'package:truecaller/presentation/screens/settings/settings_screen.dart';
import 'package:truecaller/presentation/screens/transactions/account_select_screen.dart';
import 'package:truecaller/presentation/screens/transactions/payment_screen.dart';
import 'package:truecaller/presentation/screens/transactions/receive_screen.dart';
import 'package:truecaller/presentation/screens/transactions/transfer_screen.dart';

import '../presentation/screens/error.dart';
import '../presentation/screens/reports/report_screen.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      name: 'ONBOARD',
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: const OnboardScreen(),
      ),
    ),
    GoRoute(
      path: '/home',
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
        pageBuilder: (context, state) {
          Map extra = state.extra! as Map;

          return buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: AccountsScreen(parent: extra['parent']),
          );
        },
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
              name: 'CREATE',
              pageBuilder: (context, state) {
                Map extra = state.extra! as Map;
                return buildPageWithDefaultTransition<void>(
                  context: context,
                  state: state,
                  child: AccountCreateScreen(
                    parent: extra['parent'],
                  ),
                );
              }),
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
          GoRoute(
              path: 'statement',
              name: "STATEMENT",
              pageBuilder: (context, state) {
                AccountsModel account = state.extra as AccountsModel;
                return buildPageWithDefaultTransition<void>(
                  context: context,
                  state: state,
                  child: AccountStatementScreen(account: account),
                );
              }),
        ]),
    GoRoute(
      path: '/settings',
      name: "SETTINGS",
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: const SettingsScreen(),
      ),
      routes: [
        GoRoute(
          path: 'bank-account',
          name: 'BANK-ACCOUNT',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: const SettingsBankAccountScreen());
          },
        ),
      ],
    ),
    GoRoute(
        path: '/transaction',
        name: 'TRANSACTION',
        pageBuilder: (BuildContext context, GoRouterState state) {
          //TODO
          return buildPageWithDefaultTransition(
              context: context, state: state, child: const HomeScreen());
        },
        routes: [
          GoRoute(
            path: 'account-select',
            name: 'ACCOUNT-SELECT',
            pageBuilder: (BuildContext context, GoRouterState state) {
              Map extra = state.extra! as Map;
              return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: AccountSelectScreen(
                    allowedTransactionType: extra['allowedTransactionType'],
                  ));
            },
          ),
        ]),
    GoRoute(
      path: '/payment',
      name: 'PAYMENT',
      pageBuilder: (BuildContext context, GoRouterState state) {
        AccountsModel account = state.extra as AccountsModel;
        return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: PaymentScreen(
              account: account,
            ));
      },
    ),
    GoRoute(
      path: '/receipt',
      name: 'RECEIPT',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return buildPageWithDefaultTransition<void>(
            context: context, state: state, child: const ReceiveScreen());
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
