import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnify/app_router.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/models/cart_item_model.dart';
import 'package:furnify/riverpod/cart_notifier.dart';
import 'package:furnify/widgets/custom_appbar.dart';
import 'package:furnify/widgets/custom_bottom_sheet.dart';
import 'package:furnify/widgets/product_cart_card.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage>
    with AutomaticKeepAliveClientMixin<CartPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cartItems = ref.watch(cartProvider);

    double totalCost = 0;
    for (var cartItem in cartItems) {
      totalCost += cartItem.productPrize * cartItem.quantity;
    }

    final double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: CustomBottomSheet(
        maxWidth: maxWidth,
        totalCost: totalCost,
        buttonIcon: Symbols.shopping_bag_rounded,
        buttonLabel: 'Checkout',
        buttonOnTap: () => Navigator.of(context)
            .push(AppRouter.checkoutPage(cartItems: cartItems)),
      ),
      appBar: homeAppBar(
        context: context,
        leading: Row(
          children: [
            const SizedBox(width: 15),
            const Icon(
              Symbols.shopping_cart_rounded,
              size: 30,
              weight: 600,
            ),
            const SizedBox(width: 10),
            Text(
              "My Cart",
              style: TextStyleConstants.appBar,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(right: 15, left: 15, bottom: 90, top: 15),
        child: cartItems.isEmpty
            ? Center(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    const Icon(
                      Symbols.shopping_cart_off_rounded,
                      size: 150,
                      weight: 500,
                    ),
                    Text(
                      "Your cart is empty!",
                      style: TextStyleConstants.titleMedium,
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: cartItems.length,
                    physics: const NeverScrollableScrollPhysics(),
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final ItemModel cartItem = cartItems[index];
                      return ProductCartCard(item: cartItem);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 15);
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
