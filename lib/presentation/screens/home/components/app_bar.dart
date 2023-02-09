import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      surfaceTintColor: Colors.transparent,
      title: const Text("FINDO"),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Iconsax.notification))
      ],
    );
  }
}
