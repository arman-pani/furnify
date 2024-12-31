import 'package:flutter/material.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/constants/theme_constants.dart';
import 'package:furnify/helper_methoda.dart';
import 'package:furnify/models/cart_item_model.dart';
import 'package:furnify/models/order_model.dart';
import 'package:furnify/widgets/billing_summary.dart';
import 'package:furnify/widgets/custom_appbar.dart';
import 'package:furnify/widgets/product_cart_card.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

class OrderReceiptPage extends StatefulWidget {
  final OrderModel order;
  const OrderReceiptPage({super.key, required this.order});

  @override
  State<OrderReceiptPage> createState() => _OrderReceiptPageState();
}

class _OrderReceiptPageState extends State<OrderReceiptPage> {
  @override
  Widget build(BuildContext context) {
    double grandTotal = calculateGrandTotal(widget.order.billingDetails);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        title: 'Order Receipt',
        context: context,
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(Symbols.download_rounded),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {},
            child: const Icon(Symbols.share_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 30),
        child: Column(
          children: [
            ListView.separated(
              itemCount: widget.order.itemList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              clipBehavior: Clip.none,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final ItemModel orderItem = widget.order.itemList[index];
                debugPrint("OrderItem: ${orderItem.toString()}");
                return ProductCartCard(
                  item: orderItem,
                  isEditable: false,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 15),
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
                  bill: widget.order.billingDetails,
                  grandTotal: grandTotal,
                )
              ],
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Details",
                  style: TextStyleConstants.titleMedium,
                ),
                const SizedBox(height: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  width: double.infinity,
                  decoration: ThemeConstants.greyBoxDecoration,
                  child: Column(
                    children: [
                      detailRow(
                        leading: 'Order ID',
                        tailing: widget.order.id,
                      ),
                      const SizedBox(height: 5),
                      detailRow(
                        leading: 'Order Time',
                        tailing: DateFormat("h:mm a")
                            .format(widget.order.orderDateTime),
                      ),
                      const SizedBox(height: 5),
                      detailRow(
                        leading: 'Order Date',
                        tailing: DateFormat("MMM d, yyyy")
                            .format(widget.order.orderDateTime),
                      ),
                      const SizedBox(height: 5),
                      detailRow(
                        leading: 'Payment Mode',
                        tailing: 'UPI',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Details",
                      style: TextStyleConstants.titleMedium,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      width: double.infinity,
                      decoration: ThemeConstants.greyBoxDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          detailRow(
                            leading: 'Delivery Date',
                            tailing: DateFormat("MMM d, yyyy")
                                .format(widget.order.deliveryDate),
                          ),
                          // detailRow(
                          //   leading: 'Delivery Time',
                          //   tailing: DateFormat("h:mm a")
                          //       .format(widget.order.deliveryDate),
                          // ),
                          const SizedBox(height: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shipping Address',
                                style: TextStyleConstants.orderDeliveryDate,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${widget.order.shippingAddress.address1} ${widget.order.shippingAddress.address2}',
                                style: TextStyleConstants.orderDeliveryDate
                                    .copyWith(fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget detailRow({required String leading, required String tailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          leading,
          style: TextStyleConstants.orderDeliveryDate,
          overflow: TextOverflow.ellipsis,
        ),
        const Spacer(),
        SizedBox(
          width: 120,
          child: Text(
            tailing,
            textAlign: TextAlign.end,
            style: TextStyleConstants.orderDeliveryDate,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
