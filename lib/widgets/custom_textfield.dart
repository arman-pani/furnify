import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furnify/constants/textstyle_constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    InputBorder textFieldInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.black,
        width: 2,
      ),
    );
    return TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
      cursorColor: Colors.black,
      cursorErrorColor: Colors.black,
      style: TextStyleConstants.textFieldInput,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                size: 30,
                weight: 500,
                color: Colors.black,
              )
            : null,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: textFieldInputBorder,
        focusedBorder: textFieldInputBorder,
        disabledBorder: textFieldInputBorder,
        enabledBorder: textFieldInputBorder,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        hintStyle: TextStyleConstants.textFieldInput,
        hintText: hintText,
      ),
    );
  }
}
