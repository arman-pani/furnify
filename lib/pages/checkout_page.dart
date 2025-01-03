import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnify/app_router.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/helper_methoda.dart';
import 'package:furnify/models/address_model.dart';
import 'package:furnify/models/billing_model.dart';
import 'package:furnify/models/cart_item_model.dart';
import 'package:furnify/models/order_model.dart';
import 'package:furnify/riverpod/address_notifier.dart';
import 'package:furnify/riverpod/cart_notifier.dart';
import 'package:furnify/riverpod/riverpod_provider.dart';
import 'package:furnify/services/common_methods.dart';
import 'package:furnify/utils/show_snackbar.dart';
import 'package:furnify/widgets/address_card.dart';
import 'package:furnify/widgets/billing_summary.dart';
import 'package:furnify/widgets/custom_appbar.dart';
import 'package:furnify/widgets/custom_bottom_sheet.dart';
import 'package:furnify/widgets/custom_button.dart';
import 'package:furnify/widgets/product_cart_card.dart';
import 'package:material_symbols_icons/symbols.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  final List<ItemModel> cartItems;
  const CheckoutPage({super.key, required this.cartItems});

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  Future<void>? _pendingAddOrder;

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;

    double subTotal = 0;
    for (var cartItem in widget.cartItems) {
      subTotal += cartItem.productPrize * cartItem.quantity;
    }

    List<BillingModel> dummyBilling = [
      BillingModel(title: 'SubTotal', amount: subTotal),
      BillingModel(title: 'Platform Fee', amount: 1.20),
      BillingModel(title: 'Delivery Fee', amount: 15.00),
    ];

    double grandTotal = calculateGrandTotal(dummyBilling);

    final List<AddressModel> addressList = ref.watch(addressProvider);

    final AddressModel? defaultAddress;
    if (addressList.isEmpty) {
      defaultAddress = null;
    } else {
      defaultAddress = addressList.firstWhere((address) => address.isDefault);
    }

    void onTapPaymentButton() async {
      try {
        final ordersNotifier = ref.read(orderNotifierProvider.notifier);
        final cartNotifier = ref.read(cartProvider.notifier);
        final user = await getUserFromPrefs();

        final order = OrderModel(
          id: '',
          totalPrize: grandTotal,
          billingDetails: dummyBilling,
          itemList: widget.cartItems,
          isDelivered: false,
          deliveryDate: DateTime(2025, 1, 12),
          orderDateTime: DateTime.now(),
          shippingAddress: defaultAddress!,
        );

        final future = ordersNotifier.addOrder(order, user, context);

        setState(() {
          _pendingAddOrder = future;
        });

        cartNotifier.clearCart();
      } catch (error) {
        debugPrint(error.toString());
        showSnackBar(context: context, text: error.toString());
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: CustomBottomSheet(
        maxWidth: maxWidth,
        totalCost: grandTotal,
        buttonLabel: "Payment",
        buttonIcon: Symbols.payment_rounded,
        buttonOnTap: onTapPaymentButton,
      ),
      appBar: customAppBar(
        title: "Checkout",
        context: context,
      ),
      body: FutureBuilder(
        future: _pendingAddOrder,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.black));
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 50, color: Colors.red),
                  const SizedBox(height: 20),
                  Text(
                    'Failed to submit order. Please try again.',
                    style: TextStyleConstants.titleRegular,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    label: 'Retry',
                    onPressed: onTapPaymentButton,
                    isBlack: true,
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 90),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Shipping Address",
                          style: TextStyleConstants.titleMedium,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .push(AppRouter.shippingAddressPage()),
                          child: const Icon(
                            Symbols.edit_rounded,
                            size: 25,
                            weight: 600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    defaultAddress != null
                        ? AddressCard(
                            addressModel: defaultAddress,
                            isEditable: false,
                          )
                        : CustomButton(
                            label: 'Add shipping address',
                            onPressed: () => Navigator.of(context)
                                .push(AppRouter.shippingAddressPage()),
                            isBlack: true,
                          )
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order List",
                      style: TextStyleConstants.titleMedium,
                    ),
                    const SizedBox(height: 15),
                    ListView.separated(
                      itemCount: widget.cartItems.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final ItemModel cartItem = widget.cartItems[index];
                        return ProductCartCard(
                          item: cartItem,
                          isEditable: false,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Billing Summary",
                      style: TextStyleConstants.titleMedium,
                    ),
                    const SizedBox(height: 15),
                    BillingSummary(
                      bill: dummyBilling,
                      grandTotal: grandTotal,
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
