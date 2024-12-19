import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furnify/app_router.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/constants/theme_constants.dart';
import 'package:furnify/models/product_model.dart';
import 'package:furnify/widgets/favourite_button.dart';

class ProductExploreCard extends StatelessWidget {
  final ProductModel product;
  const ProductExploreCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        AppRouter.productPage(product: product),
      ),
      child: Container(
        width: double.infinity,
        height: 125,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: ThemeConstants.greyBoxDecoration,
        child: Row(
          children: [
            SvgPicture.network(
              product.imageUrlList[0],
              fit: BoxFit.cover,
              width: 90,
              height: 90,
              placeholderBuilder: (context) {
                return const Center(
                  child: Icon(
                    Icons.image,
                    weight: 200,
                    size: 90,
                  ),
                );
              },
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyleConstants.titleRegular,
                ),
                Text(
                  product.company,
                  style: TextStyleConstants.subTitle,
                ),
                const Spacer(),
                StarRating(
                  rating: product.rating,
                  color: Colors.black,
                  allowHalfRating: true,
                  onRatingChanged: (rating) {},
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FavouriteButton(product: product),
                Text(
                  "₹${product.prize.toInt()}",
                  style: TextStyleConstants.titleMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
