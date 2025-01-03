import 'package:flutter/material.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/widgets/custom_appbar.dart';
import 'package:furnify/widgets/custom_button.dart';
import 'package:furnify/widgets/custom_textfield.dart';
import 'package:material_symbols_icons/symbols.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController codeController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: 'Verify your Email', context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Icon(
              Symbols.drafts_rounded,
              color: Colors.black,
              size: 175,
            ),
            Text(
              "Please enter the verification code sent to example@gmail.com",
              textAlign: TextAlign.center,
              style: TextStyleConstants.textFieldInput,
            ),
            const SizedBox(height: 30),
            CustomTextField(
              controller: codeController,
              hintText: 'Email Address',
              prefixIcon: Symbols.email_rounded,
            ),
            const SizedBox(height: 30),
            CustomButton(
              label: 'Send code',
              onPressed: () {},
              isBlack: true,
            )
          ],
        ),
      ),
    );
  }
}
