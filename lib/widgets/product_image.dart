import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// one place to load images, with error handling
class ProductImage extends StatelessWidget {
  final String url;
  final IconData icon; // shown when the image cannot be loaded
  final BoxFit fit;

  const ProductImage({
    super.key,
    required this.url,
    this.icon = Icons.image_not_supported,
    this.fit = BoxFit.cover,
  });

  Widget errorBox() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF1C2), Color(0xFFFFFFFF)],
        ),
      ),
      child: Center(child: Icon(icon, size: 56, color: AppColors.ink)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // links start with http, everything else is a local asset
    if (url.startsWith('http')) {
      return Image.network(
        url,
        fit: fit,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        },
        errorBuilder: (context, error, stackTrace) => errorBox(),
      );
    }

    return Image.asset(
      url,
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) => errorBox(),
    );
  }
}