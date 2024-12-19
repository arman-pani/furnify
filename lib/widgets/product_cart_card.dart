import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/constants/theme_constants.dart';
import 'package:furnify/models/cart_item_model.dart';
import 'package:furnify/riverpod/cart_notifier.dart';
import 'package:furnify/widgets/quantity_selector.dart';
import 'package:material_symbols_icons/symbols.dart';

class ProductCartCard extends ConsumerStatefulWidget {
  final ItemModel item;
  final bool isEditable;

  const ProductCartCard({
    super.key,
    required this.item,
    this.isEditable = true,
  });

  @override
  ConsumerState<ProductCartCard> createState() => _ProductCartCardState();
}

class _ProductCartCardState extends ConsumerState<ProductCartCard> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.read(cartProvider.notifier);
    return Container(
      width: double.infinity,
      height: 125,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: ThemeConstants.greyBoxDecoration,
      child: Row(
        children: [
          SvgPicture.network(
            widget.item.productImageUrl,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.productName,
                style: TextStyleConstants.titleRegular,
              ),
              Text(
                widget.item.productCompany,
                style: TextStyleConstants.subTitle,
              ),
              const Spacer(),
              widget.isEditable
                  ? Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            cart.removeFromCart(
                                productId: widget.item.productId);
                          },
                          child: const Icon(
                            Symbols.delete_rounded,
                            weight: 600,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {}

                          // Navigator.of(context).push(
                          //   AppRouter.productPage(
                          //       product: widget.product),
                          // )
                          ,
                          child: const Icon(
                            Symbols.arrow_outward_rounded,
                            weight: 600,
                            size: 24,
                          ),
                        )
                      ],
                    )
                  : Container(),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${widget.item.productPrize.toInt()}",
                style: TextStyleConstants.titleMedium,
              ),
              widget.isEditable
                  ? QuantitySelector(
                      initialValue: widget.item.quantity,
                      onChanged: (value) {
                        cart.updateQuantity(
                          productId: widget.item.productId,
                          newQuantity: value,
                        );
                      },
                    )
                  : Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          widget.item.quantity.toString(),
                          style: TextStyleConstants.tabLabel
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }
}
