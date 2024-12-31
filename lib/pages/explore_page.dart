import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnify/app_router.dart';
import 'package:furnify/constants/color_constants.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/models/product_model.dart';
import 'package:furnify/riverpod/riverpod_provider.dart';
import 'package:furnify/widgets/custom_appbar.dart';
import 'package:furnify/widgets/custom_search_bar.dart';
import 'package:furnify/widgets/location_widget.dart';
import 'package:furnify/widgets/product_explore_card.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage>
    with AutomaticKeepAliveClientMixin<ExplorePage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final trendingProducts = ref.watch(getTrendingProductsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          homeAppBar(context: context, leading: const CurrentLocationWidget()),
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
                        label: "Chair",
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
                trendingProducts.when(
                  data: (trendingProducts) => ListView.separated(
                    shrinkWrap: true,
                    itemCount: trendingProducts.length,
                    physics: const NeverScrollableScrollPhysics(),
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final ProductModel product = trendingProducts[index];
                      return ProductExploreCard(product: product);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 15);
                    },
                  ),
                  error: (_, __) =>
                      const Center(child: Text('An error occurred')),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                )
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
