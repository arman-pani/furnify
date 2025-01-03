import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnify/constants/color_constants.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/helper_methoda.dart';
import 'package:furnify/models/cart_item_model.dart';
import 'package:furnify/models/product_model.dart';
import 'package:furnify/riverpod/cart_notifier.dart';
import 'package:furnify/widgets/custom_button.dart';
import 'package:furnify/widgets/favourite_button.dart';
import 'package:furnify/widgets/quantity_selector.dart';
import 'package:furnify/widgets/share_button.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final customButtonWidth = (maxWidth - 40) / 2;
    const buttonPadding = EdgeInsets.symmetric(horizontal: 15, vertical: 5);

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
              padding: buttonPadding,
              isBlack: true,
              icon: Symbols.shopping_bag_speed_rounded,
              customWidth: customButtonWidth,
              label: 'Buy Now',
              onPressed: () {},
            ),
            const Spacer(),
            CustomButton(
              padding: buttonPadding,
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
                      Expanded(
                        child: Text(
                          widget.product.name,
                          style: TextStyleConstants.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "\$${widget.product.prize.toInt()}",
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
                        softWrap: true,
                        widget.product.description,
                        style: TextStyleConstants.subTitle,
                        textAlign: TextAlign.justify,
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

class ProductImageSlideShow extends StatefulWidget {
  final ProductModel product;
  final double maxWidth;

  const ProductImageSlideShow({
    super.key,
    required this.maxWidth,
    required this.product,
  });

  @override
  State<ProductImageSlideShow> createState() => _ProductImageSlideShowState();
}

class _ProductImageSlideShowState extends State<ProductImageSlideShow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.maxWidth,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 10),
      color: ColorConstants.primaryColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Symbols.arrow_back_rounded,
                  size: 30,
                  weight: 600,
                ),
              ),
              const Spacer(),
              ShareButton(
                shareText:
                    "Check out this product!\n\nName: ${widget.product.name}\nCompany: ${widget.product.company}\nPrice: ${widget.product.prize}\n\n${widget.product.imageUrlList[0]}",
                imageUrl: widget.product.imageUrlList[0],
              ),
              const SizedBox(width: 15),
              FavouriteButton(product: widget.product),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: widget.product.imageUrlList.isEmpty
                ? const Icon(
                    Icons.image,
                    weight: 200,
                    size: 90,
                  )
                : PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: widget.product.imageUrlList.length,
                    itemBuilder: (context, index) {
                      final imageName = widget.product.imageUrlList[index];

                      return FutureBuilder(
                        future: getImageUrl(imageName),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.black),
                            );
                          }

                          if (snapshot.hasError ||
                              !snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                              child:
                                  Icon(Symbols.image_not_supported, size: 90),
                            );
                          }

                          return Image.network(
                            snapshot.data.toString(),
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.black),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Symbols.image_not_supported,
                                  size: 90);
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 30, height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.product.imageUrlList.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 12 : 8,
                    height: _currentPage == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color:
                          _currentPage == index ? Colors.black : Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => launchUrl(Uri.parse(widget.product.glbModelUrl)),
                child: const Icon(
                  Symbols.view_in_ar,
                  size: 30,
                  weight: 600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
