import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truecaller/presentation/widgets/container_block.dart';

import '../../widgets/bottom_navigation.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: const Text(
          "REPORTS",
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Iconsax.search_favorite,
                // color: Colors.black,
              ))
        ],
      ),
      bottomNavigationBar: const BottomNavigation(
        index: 1,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const BoxedContainer(
              content: Text("All Reports"),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    dense: true,
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    title: Text(
                      "Account Statement",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text("This is description of report"),
                  ),
                  ListTile(
                    dense: true,
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    title: Text(
                      "Cash Book",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text("This is description of report"),
                  ),
                  ListTile(
                    dense: true,
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    title: Text(
                      "Bank Book",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text("This is description of report"),
                  ),
                  const Divider(),
                  ListTile(
                    dense: true,
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    title: Text(
                      "Daily Transactions",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text("This is description of report"),
                  ),
                  ListTile(
                    dense: true,
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    title: Text(
                      "Monthly Transactions",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text("This is description of report"),
                  ),
                  const Divider(),
                  ListTile(
                    dense: true,
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    title: Text(
                      "Budget Report",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text("This is description of report"),
                  ),
                  ListTile(
                    dense: true,
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    title: Text(
                      "Report Title",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text("This is description of report"),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
