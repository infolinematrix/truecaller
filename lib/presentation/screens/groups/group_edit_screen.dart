import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupEditScreen extends ConsumerWidget {
  const GroupEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Group")),
      body: const SafeArea(child: Text("sdfd")),
    );
  }
}