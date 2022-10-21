import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HostedImage extends StatelessWidget {
  final String imageurl;
  final double asdpectRatio;
  final BoxFit? fit;
  const HostedImage(
      {Key? key, required this.imageurl, required this.asdpectRatio, this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: asdpectRatio,
      child: CachedNetworkImage(
        imageUrl: imageurl,
        fit: fit ?? BoxFit.contain,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            LinearProgressIndicator(
          value: downloadProgress.progress,
          color: const Color.fromARGB(255, 247, 247, 247),
          backgroundColor: Colors.white,
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.error,
          color: Colors.grey.shade100,
        ),
      ),
    );
  }
}
