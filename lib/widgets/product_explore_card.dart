import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:furnify/app_router.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/constants/theme_constants.dart';
import 'package:furnify/models/product_model.dart';
import 'package:furnify/widgets/favourite_button.dart';
import 'package:furnify/widgets/product_image_widget.dart';

class ProductExploreCard extends StatelessWidget {
  final ProductModel product;
  const ProductExploreCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    debugPrint(product.toString());
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
            product.imageUrlList.isEmpty
                ? const Icon(
                    Icons.image,
                    weight: 200,
                    size: 90,
                  )
                : ProductImageWidget(imageName: product.imageUrlList[0]),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: TextStyleConstants.titleRegular,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      FavouriteButton(product: product),
                    ],
                  ),
                  Text(
                    product.company,
                    style: TextStyleConstants.subTitle,
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StarRating(
                        rating: product.rating,
                        color: Colors.black,
                        allowHalfRating: true,
                        onRatingChanged: (rating) {},
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "\$${product.prize.toInt()}",
                        style: TextStyleConstants.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
