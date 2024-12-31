import 'package:flutter/material.dart';
import 'package:furnify/app_router.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/widgets/custom_appbar.dart';
import 'package:furnify/widgets/custom_button.dart';
import 'package:furnify/widgets/custom_textfield.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: 'Forget Password', context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Icon(
              Symbols.lock_clock_rounded,
              color: Colors.black,
              size: 175,
            ),
            Text(
              "Please enter your email address to receive a verification code.",
              textAlign: TextAlign.center,
              style: TextStyleConstants.textFieldInput,
            ),
            const SizedBox(height: 30),
            CustomTextField(
              controller: emailController,
              hintText: 'Email Address',
              prefixIcon: Symbols.email_rounded,
            ),
            const SizedBox(height: 30),
            CustomButton(
              label: 'Send code',
              onPressed: () {
                Navigator.of(context).push(AppRouter.emailVerificationPage());
              },
              isBlack: true,
            )
          ],
        ),
      ),
    );
  }
}
