import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountCreateScreen extends ConsumerWidget {
  const AccountCreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),
      body: const SafeArea(child: Text("sdfd")),
    );
  }
}
