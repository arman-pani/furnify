import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/constants/theme_constants.dart';
import 'package:furnify/models/cart_item_model.dart';
import 'package:furnify/riverpod/cart_notifier.dart';
import 'package:furnify/widgets/product_image_widget.dart';
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
          ProductImageWidget(imageName: widget.item.productImageUrl),
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
                        widget.item.productName,
                        style: TextStyleConstants.titleRegular,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "\$${widget.item.productPrize.toInt()}",
                      style: TextStyleConstants.titleMedium,
                    ),
                  ],
                ),
                Text(
                  widget.item.productCompany,
                  style: TextStyleConstants.subTitle,
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: widget.isEditable
                      ? [
                          Row(
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
                                onTap: () {},
                                child: const Icon(
                                  Symbols.arrow_outward_rounded,
                                  weight: 600,
                                  size: 24,
                                ),
                              )
                            ],
                          ),
                          QuantitySelector(
                            initialValue: widget.item.quantity,
                            onChanged: (value) {
                              cart.updateQuantity(
                                productId: widget.item.productId,
                                newQuantity: value,
                              );
                            },
                          )
                        ]
                      : [
                          Container(),
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 17.5,
                            child: Text(
                              widget.item.quantity.toString(),
                              style: TextStyleConstants.tabLabel
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
