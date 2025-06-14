import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String img;
  final double width;
  final double height;
  const CachedImage({
    super.key,
    required this.img,
    this.width = 50,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: img,
      width: width,
      height: height,
      fit: BoxFit.cover,
      alignment: Alignment.center,
      placeholder: (context, url) => Icon(
        Icons.image,
        size: 40,
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        size: 40,
      ),
    );
  }
}
