import 'package:flutter/material.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/widgets/custom_button.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.maxWidth,
    required this.totalCost,
    required this.buttonLabel,
    required this.buttonIcon,
    required this.buttonOnTap,
  });

  final double maxWidth;
  final double totalCost;
  final String buttonLabel;
  final IconData buttonIcon;
  final VoidCallback buttonOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(width: 0.25, color: Colors.black),
        ),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Cost",
                style: TextStyleConstants.smallText,
              ),
              Text(
                "\$${totalCost.toStringAsFixed(2)}",
                style: TextStyleConstants.titleMedium,
              ),
            ],
          ),
          const Spacer(),
          CustomButton(
            label: buttonLabel,
            icon: buttonIcon,
            onPressed: buttonOnTap,
            isBlack: true,
            customWidth: maxWidth / 2,
          )
        ],
      ),
    );
  }
}
