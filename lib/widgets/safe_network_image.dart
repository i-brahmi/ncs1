import 'package:flutter/material.dart';


class SafeNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final String fallbackUrl;

  const SafeNetworkImage({
    super.key,
    required this.imageUrl,
    required this.radius,
    required this.fallbackUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[200],
      backgroundImage: NetworkImage(imageUrl ?? fallbackUrl),
      onBackgroundImageError: (_, __) {
        // Force rebuild to show fallback image
        // This rebuilds with fallback
        (context as Element).markNeedsBuild();
      },
      child: imageUrl == null || imageUrl!.isEmpty
          ? Image.network(fallbackUrl, fit: BoxFit.cover)
          : null,
    );
  }
}
