import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupCreateScreen extends ConsumerWidget {
  const GroupCreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Group")),
      body: SafeArea(child: Text("sdfd")),
    );
  }
}
