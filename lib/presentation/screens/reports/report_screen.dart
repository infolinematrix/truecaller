import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../widgets/bottom_navigation.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
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
      body: const SafeArea(child: Text("ABCD")),
    );
  }
}
