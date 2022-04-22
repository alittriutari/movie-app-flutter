import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCacheImage extends StatelessWidget {
  final String imageUrl;
  final double height, width;
  final BoxFit? boxFit;
  const CustomCacheImage({Key? key, required this.imageUrl, this.height = 0.0, this.width = 0.0, this.boxFit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: boxFit,
      width: width,
      height: height,
      placeholder: (context, url) => Image.asset(
        'assets/loading.gif',
        fit: BoxFit.cover,
        height: height,
        width: width,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
