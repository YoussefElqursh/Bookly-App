import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget featuredListWidget({
  required BuildContext context,
  required String imageUrl,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: AspectRatio(
      aspectRatio: 2.6/4,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
        errorWidget: (context, url, error) => const Icon(Icons.info_outline),
        fit: BoxFit.fill,
      ),
    ),
  );
}