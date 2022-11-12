import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truecaller/utils/ui_helper.dart';

class DrawerNavigation extends StatelessWidget {
  const DrawerNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAccountsDrawerHeader(
              accountEmail:
                  const Text(''), // keep blank text because email is required
              accountName: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).platform == TargetPlatform.iOS
                              ? const Color(0xFF00897b)
                              : Colors.white,
                      child: Text(
                        "S",
                        style: TextStyle(
                            fontSize: 30.0.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  UIHelper.horizontalSpaceMedium(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Ashish Rawat'),
                      Text(
                        'Since : 24th October, 2022',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "MAIN NAVIGATION",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text("Home",
                      style: Theme.of(context).textTheme.subtitle2),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text("Home",
                      style: Theme.of(context).textTheme.subtitle2),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text("Home",
                      style: Theme.of(context).textTheme.subtitle2),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text("Home",
                      style: Theme.of(context).textTheme.subtitle2),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text("Home",
                      style: Theme.of(context).textTheme.subtitle2),
                ),
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "USEFUL LINKS",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text("Home",
                      style: Theme.of(context).textTheme.subtitle2),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text("Home",
                      style: Theme.of(context).textTheme.subtitle2),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text("Home",
                      style: Theme.of(context).textTheme.subtitle2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
