import 'package:flutter/material.dart';
import 'package:furnify/constants/color_constants.dart';
import 'package:furnify/constants/textstyle_constants.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final bool isBlack;
  final EdgeInsets? padding;
  // final double maxWidth;
  final VoidCallback onPressed;
  final IconData? icon;
  final double? customWidth;
  const CustomButton({
    super.key,
    this.padding,
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
              color: isBlack ? Colors.white : Colors.black,
              weight: 600,
            ),
      style: ElevatedButton.styleFrom(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 15),
        backgroundColor: isBlack ? Colors.black : ColorConstants.primaryColor,
        foregroundColor: isBlack ? Colors.white : Colors.black,
        maximumSize: Size(maxWidth, 50),
        minimumSize: Size(maxWidth, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: TextStyleConstants.buttonLabel,
      ),
      label: Text(
        label,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
