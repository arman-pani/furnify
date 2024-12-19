import 'package:flutter/material.dart';
import 'package:furnify/app_router.dart';
import 'package:furnify/constants/color_constants.dart';
import 'package:furnify/constants/dummy_data.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/models/product_model.dart';
import 'package:furnify/widgets/custom_appbar.dart';
import 'package:furnify/widgets/custom_search_bar.dart';
import 'package:furnify/widgets/product_explore_card.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin<ExplorePage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: homeAppBar(
        context: context,
        leading: Row(
          children: [
            const SizedBox(width: 15),
            const Icon(
              Symbols.distance_rounded,
              size: 25,
              weight: 600,
            ),
            const SizedBox(width: 5),
            Text(
              "Jharapada, Bhubaneswar",
              style: TextStyleConstants.location,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 15, left: 15, bottom: 30),
        child: Column(
          children: [
            const CustomSearchBar(),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                  style: TextStyleConstants.titleMedium,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    itemCount: 5,
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return categoryCard(
                        label: "Chairs",
                        icon: Symbols.chair_rounded,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 15);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Trending Products",
                  style: TextStyleConstants.titleMedium,
                ),
                const SizedBox(height: 10),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: dummyTrendingProducts.length,
                  physics: const NeverScrollableScrollPhysics(),
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final ProductModel product = dummyTrendingProducts[index];
                    return ProductExploreCard(product: product);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 15);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryCard({required String label, required IconData icon}) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        AppRouter.catergoryPage(category: label),
      ),
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: ColorConstants.primaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 1, // How far the shadow spreads
              blurRadius: 8, // How soft the shadow is
              offset: const Offset(0, 4), // Shadow position (x, y)
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              weight: 600,
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyleConstants.smallText,
            ),
          ],
        ),
      ),
    );
  }
}
