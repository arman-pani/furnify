import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnify/riverpod/riverpod_provider.dart';
import 'package:furnify/widgets/custom_appbar.dart';
import 'package:furnify/widgets/placeholder_widget.dart';
import 'package:furnify/widgets/product_explore_card.dart';
import 'package:material_symbols_icons/symbols.dart';

class CategoryPage extends ConsumerWidget {
  final String category;
  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryProducts = ref.watch(getCategoryProductsProvider(category));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        title: category,
        context: context,
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(Symbols.search_rounded),
          ),
        ],
      ),
      body: categoryProducts.when(
        data: (categoryProducts) {
          if (categoryProducts.isEmpty) {
            return const PlaceholderWidget(
              title: "No products found",
              icon: Symbols.search_off_rounded,
            );
          } else {
            return ListView.separated(
              itemCount: categoryProducts.length,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              shrinkWrap: true,
              clipBehavior: Clip.none,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final product = categoryProducts[index];
                return ProductExploreCard(product: product);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 15),
            );
          }
        },
        error: (_, __) => const Center(
            child: PlaceholderWidget(
          title: "No products found",
          icon: Symbols.search_off_rounded,
        )),
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.black)),
      ),
    );
  }
}
