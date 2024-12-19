import 'package:flutter/material.dart';
import 'package:furnify/app_router.dart';
import 'package:furnify/constants/color_constants.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/models/order_model.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).push(AppRouter.orderReceiptPage(order: order)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: double.infinity,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Order #${order.id}",
                    style: TextStyleConstants.titleRegular,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    "View",
                    style: TextStyleConstants.smallText
                        .copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: order.itemList.length,
              itemBuilder: (context, index) {
                final item = order.itemList[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Symbols.circle_rounded,
                      size: 30,
                      weight: 600,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${item.quantity} x ${item.productName}",
                      style: TextStyleConstants.orderSubTitle,
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 1),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Delivery by ${DateFormat('MMM d, y').format(order.deliveryDate)}",
                  style: TextStyleConstants.orderDeliveryDate,
                ),
                Text(
                  "₹${order.totalPrize.toString()}",
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
