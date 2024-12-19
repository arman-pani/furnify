import 'package:flutter/material.dart';
import 'package:furnify/constants/dummy_data.dart';
import 'package:furnify/widgets/custom_appbar.dart';
import 'package:furnify/widgets/product_explore_card.dart';
import 'package:material_symbols_icons/symbols.dart';

class CategoryPage extends StatelessWidget {
  final String category;
  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView.separated(
        itemCount: 10,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        shrinkWrap: true,
        clipBehavior: Clip.none,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return ProductExploreCard(product: dummyProduct);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 15),
      ),
    );
  }
}
