import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnify/models/product_model.dart';
import 'package:furnify/riverpod/wishlist_notifier.dart';
import 'package:material_symbols_icons/symbols.dart';

class FavouriteButton extends ConsumerWidget {
  final ProductModel product;
  const FavouriteButton({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);
    final isFavorite = wishlist.any((item) => item.id == product.id);
    return GestureDetector(
      onTap: () {
        if (isFavorite) {
          ref
              .read(wishlistProvider.notifier)
              .removeFromWishlist(productId: product.id);
        } else {
          ref.read(wishlistProvider.notifier).addToWishlist(product: product);
        }
      },
      child: Icon(
        Symbols.favorite_rounded,
        size: 24,
        weight: 600,
        fill: isFavorite ? 1 : 0,
        color: isFavorite ? Colors.red : Colors.black,
      ),
    );
  }
}
