import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              GoRouter.of(context).pop();
              GoRouter.of(context).pushNamed('HOME');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Iconsax.home_1,
                  color: index == 0
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).unselectedWidgetColor,
                ), // icon
                Text(
                  "Home",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ), // text
              ],
            ),
          ),
          GestureDetector(
            onTap: () => GoRouter.of(context).push('/reports'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Iconsax.chart_square,
                  color: index == 1
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).unselectedWidgetColor,
                ), // icon
                Text(
                  "Report",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ), // text
              ],
            ),
          ),
          GestureDetector(
            onTap: () => GoRouter.of(context).push('/groups'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Iconsax.empty_wallet_change,
                  color: index == 2
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).unselectedWidgetColor,
                ), // icon
                Text(
                  "Accounts",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ), // text
              ],
            ),
          ),
          GestureDetector(
            onTap: () => GoRouter.of(context).pushNamed('SETTINGS-UPDATE'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Iconsax.personalcard,
                  color: index == 3
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).unselectedWidgetColor,
                ), // icon
                Text(
                  "Settings",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ), // text
              ],
            ),
          ),
        ],
      ),
    );
  }
}
