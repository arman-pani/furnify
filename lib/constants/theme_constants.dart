import 'package:flutter/material.dart';
import 'package:furnify/constants/color_constants.dart';

class ThemeConstants {
  static BoxDecoration greyBoxDecoration = BoxDecoration(
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
  );
}
