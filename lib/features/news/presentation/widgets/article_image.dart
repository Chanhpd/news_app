import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleImage extends StatelessWidget {
  final String imageUrl;
  final double height;

  const ArticleImage({
    super.key,
    required this.imageUrl,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        height: height,
        color: Colors.grey[300],
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: height,
        color: Colors.grey[300],
        child: const Center(
          child: Icon(Icons.image_not_supported, size: 48),
        ),
      ),
    );
  }
}
