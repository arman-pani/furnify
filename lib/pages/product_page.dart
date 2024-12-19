import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnify/constants/color_constants.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/models/cart_item_model.dart';
import 'package:furnify/models/product_model.dart';
import 'package:furnify/riverpod/cart_notifier.dart';
import 'package:furnify/widgets/custom_button.dart';
import 'package:furnify/widgets/favourite_button.dart';
import 'package:furnify/widgets/quantity_selector.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ProductPage extends ConsumerStatefulWidget {
  final ProductModel product;
  const ProductPage({super.key, required this.product});

  @override
  ConsumerState<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  int selectedQuantity = 1;

  void onChangedQuantitySelector(value) {
    setState(() {
      selectedQuantity = value;
    });
  }

  void addProductToCart(
      {required ProductModel product, required int quantity}) {
    final cart = ref.read(cartProvider.notifier);

    final ItemModel cartItem = ItemModel(
      productId: product.id,
      productName: product.name,
      productCompany: product.company,
      productPrize: product.prize,
      productImageUrl: product.imageUrlList[0],
      quantity: quantity,
    );

    cart.addToCart(cartItem: cartItem);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Successfully added $quantity ${product.name} to cart.'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final customButtonWidth = (maxWidth - 60) / 2;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: Container(
        height: 75,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border.symmetric(
            horizontal: BorderSide(width: 0.25, color: Colors.black),
          ),
        ),
        child: Row(
          children: [
            CustomButton(
              isBlack: true,
              icon: Symbols.shopping_bag_speed_rounded,
              customWidth: customButtonWidth,
              label: 'Buy Now',
              onPressed: () {},
            ),
            const Spacer(),
            CustomButton(
              isBlack: false,
              icon: Symbols.shopping_cart_rounded,
              customWidth: customButtonWidth,
              label: 'Add to Cart',
              onPressed: () {
                addProductToCart(
                  product: widget.product,
                  quantity: selectedQuantity,
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductImageSlideShow(
              maxWidth: maxWidth,
              product: widget.product,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyleConstants.appBar,
                      ),
                      Text(
                        widget.product.prize.toString(),
                        style: TextStyleConstants.appBar,
                      ),
                    ],
                  ),
                  Text(
                    widget.product.company,
                    style: TextStyleConstants.smallText,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StarRating(
                        rating: widget.product.rating,
                        color: Colors.black,
                        allowHalfRating: true,
                        onRatingChanged: (rating) {},
                      ),
                      QuantitySelector(
                        initialValue: selectedQuantity,
                        onChanged: (value) => onChangedQuantitySelector(value),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyleConstants.smallText,
                      ),
                      Text(
                        """Lorem ipsum dolor sit amet consectetur. Eget varius tempor purus imperdiet gravida facilisi at amet fringilla. Nisl auctor morbi posuere aliquam nisl.""",
                        style: TextStyleConstants.subTitle,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductImageSlideShow extends StatelessWidget {
  final ProductModel product;
  const ProductImageSlideShow({
    super.key,
    required this.maxWidth,
    required this.product,
  });

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: maxWidth,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 10),
      color: ColorConstants.primaryColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Symbols.arrow_back_rounded,
                size: 30,
                weight: 600,
              ),
              FavouriteButton(product: product),
            ],
          ),
          const Spacer(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 30,
                height: 30,
              ),
              Icon(
                Symbols.page_control_rounded,
                size: 40,
                weight: 600,
              ),
              Icon(
                Symbols.view_in_ar,
                size: 30,
                weight: 600,
              ),
            ],
          )
        ],
      ),
    );
  }
}
