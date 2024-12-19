import 'package:flutter/material.dart';
import 'package:furnify/constants/color_constants.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 1, // How far the shadow spreads
            blurRadius: 8, // How soft the shadow is
            offset: Offset(0, 4), // Shadow position (x, y)
          ),
        ],
      ),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Symbols.search_rounded,
            weight: 600,
            size: 30,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          hintText: "Search",
          hintStyle: TextStyleConstants.textFieldInput,
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
