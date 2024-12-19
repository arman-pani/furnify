import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  const PasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  late bool isObscure;
  @override
  void initState() {
    super.initState();
    isObscure = true;
  }

  @override
  Widget build(BuildContext context) {
    InputBorder textFieldInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.black, width: 2),
    );
    return TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
      cursorColor: Colors.black,
      cursorErrorColor: Colors.black,
      style: TextStyleConstants.textFieldInput,
      controller: widget.controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Symbols.lock_rounded,
          size: 30,
          weight: 500,
          color: Colors.black,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          icon: Icon(
            isObscure
                ? Symbols.visibility_off_rounded
                : Symbols.visibility_rounded,
            size: 30,
            weight: 600,
            color: Colors.black,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: textFieldInputBorder,
        focusedBorder: textFieldInputBorder,
        disabledBorder: textFieldInputBorder,
        enabledBorder: textFieldInputBorder,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        hintStyle: TextStyleConstants.textFieldInput,
        hintText: widget.hintText,
      ),
    );
  }
}
