import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatelessWidget {
  final String imageurl;
  const SvgImage({Key? key, required this.imageurl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: SvgPicture.asset(
        imageurl,
        color: Colors.black87,
      ),
    );
  }
}
