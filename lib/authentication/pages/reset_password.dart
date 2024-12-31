import 'package:flutter/material.dart';
import 'package:furnify/app_router.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/widgets/custom_appbar.dart';
import 'package:furnify/widgets/custom_button.dart';
import 'package:furnify/widgets/pwd_textfield.dart';
import 'package:material_symbols_icons/symbols.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController pwdController = TextEditingController();
    final TextEditingController confirmPwdController = TextEditingController();

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
            PasswordTextField(
              controller: pwdController,
              hintText: 'New Password',
            ),
            const SizedBox(height: 15),
            PasswordTextField(
              controller: confirmPwdController,
              hintText: 'Confirm Password',
            ),
            const SizedBox(height: 30),
            CustomButton(
              label: 'Change Password',
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  AppRouter.logInPage(),
                  (Route<dynamic> route) => false,
                );
              },
              isBlack: true,
            )
          ],
        ),
      ),
    );
  }
}
