import 'package:flutter/material.dart';

class LocalImage extends StatelessWidget {
  final String imageurl;
  final double asdpectRatio;
  const LocalImage(
      {Key? key, required this.imageurl, required this.asdpectRatio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: asdpectRatio,
      child: Image.asset(
        imageurl,
        fit: BoxFit.contain,
      ),
    );
  }
}
