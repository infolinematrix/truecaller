import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String msg;
  const ErrorPage({required this.msg, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Text(msg),
      ),
    );
  }
}
