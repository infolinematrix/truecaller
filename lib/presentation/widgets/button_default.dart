import 'package:flutter/material.dart';

class ButtonDefault extends StatelessWidget {
  const ButtonDefault(
      {Key? key, required this.text, this.color, required this.onTap})
      : super(key: key);

  final Widget text;
  final Color? color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onTap(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        elevation: MaterialStateProperty.all<double>(0.25),
        textStyle: MaterialStateProperty.resolveWith((states) {
          return const TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
          );
        }),
      ),
      child: text,
    );
  }
}
