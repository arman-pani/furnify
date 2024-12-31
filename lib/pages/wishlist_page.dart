import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/models/product_model.dart';
import 'package:furnify/riverpod/wishlist_notifier.dart';
import 'package:furnify/widgets/custom_appbar.dart';
import 'package:furnify/widgets/product_explore_card.dart';
import 'package:material_symbols_icons/symbols.dart';

class WishListPage extends ConsumerWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        title: 'Wishlist',
        context: context,
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(Symbols.search_rounded),
          ),
        ],
      ),
      body: wishlist.isEmpty
          ? Center(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  const Icon(
                    Symbols.favorite_border_rounded,
                    size: 150,
                    weight: 500,
                  ),
                  Text(
                    "Your wishlist is empty!",
                    style: TextStyleConstants.titleMedium,
                  ),
                ],
              ),
            )
          : ListView.separated(
              itemCount: wishlist.length,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              shrinkWrap: true,
              clipBehavior: Clip.none,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final ProductModel product = wishlist[index];
                return ProductExploreCard(product: product);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 15),
            ),
    );
  }
}
