import 'package:flutter/material.dart';
import 'package:furnify/constants/color_constants.dart';
import 'package:furnify/constants/textstyle_constants.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final bool isBlack;
  // final double maxWidth;
  final VoidCallback onPressed;
  final IconData? icon;
  final double? customWidth;
  const CustomButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
    required this.isBlack,
    this.customWidth,
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = customWidth ?? MediaQuery.of(context).size.width;

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon == null
          ? Container()
          : Icon(
              icon,
              size: 25,
              weight: 600,
            ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isBlack ? Colors.black : ColorConstants.primaryColor,
        foregroundColor: isBlack ? Colors.white : Colors.black,
        minimumSize: Size(maxWidth, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: TextStyleConstants.buttonLabel,
      ),
      label: Text(label),
    );
  }
}
