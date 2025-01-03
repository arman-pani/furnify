import 'package:flutter/material.dart';
import 'package:furnify/helper_methoda.dart';

class ProductImageWidget extends StatelessWidget {
  final String imageName;
  const ProductImageWidget({super.key, required this.imageName});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getImageUrl(imageName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 80,
            height: 80,
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Icon(
              Icons.image_not_supported,
              size: 90,
            ),
          );
        } else if (snapshot.hasData) {
          final imageUrl = snapshot.data.toString();
          return Image.network(
            imageUrl,
            fit: BoxFit.contain,
            width: 80,
            height: 80,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox(
                width: 80,
                height: 80,
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.image,
                size: 90,
              );
            },
          );
        } else {
          return const Icon(
            Icons.image_not_supported,
            size: 90,
          );
        }
      },
    );
  }
}
