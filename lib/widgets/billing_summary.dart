import 'package:flutter/material.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/constants/theme_constants.dart';
import 'package:furnify/models/billing_model.dart';

class BillingSummary extends StatelessWidget {
  final List<BillingModel> bill;
  final double grandTotal;
  const BillingSummary(
      {super.key, required this.bill, required this.grandTotal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: double.infinity,
      decoration: ThemeConstants.greyBoxDecoration,
      child: Column(
        children: [
          ListView.separated(
            itemCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            clipBehavior: Clip.none,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final BillingModel billingItem = bill[index];
              return billingRow(
                label: billingItem.title,
                amount: billingItem.amount,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 5),
          ),
          dottedLine(),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyleConstants.titleMedium,
              ),
              Text(
                '\$${grandTotal.toStringAsFixed(2)}',
                style: TextStyleConstants.titleMedium,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget billingRow({required String label, required double amount}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyleConstants.orderDeliveryDate,
        ),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: TextStyleConstants.orderDeliveryDate,
        ),
      ],
    );
  }

  Widget dottedLine() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: List.generate(
          100, // Adjust for length
          (index) => Expanded(
            child: Container(
              color: index % 2 == 0 ? Colors.black : Colors.transparent,
              height: 1, // Thickness of the dotted line
            ),
          ),
        ),
      ),
    );
  }
}
