import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/widgets/custom_button.dart';
import 'package:furnify/widgets/custom_textfield.dart';
import 'package:furnify/widgets/other_platform_button.dart';
import 'package:furnify/widgets/pwd_textfield.dart';
import 'package:material_symbols_icons/symbols.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController confirmPwdController = TextEditingController();

  final TapGestureRecognizer loginOnTap = TapGestureRecognizer()
    ..onTap = () {
      print('Tapped on clickable text!');
      // Perform your action here
    };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Let's get Started",
                style: TextStyleConstants.titleLarge,
              ),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              controller: emailController,
              hintText: "Email Address",
              prefixIcon: Symbols.email_rounded,
            ),
            const SizedBox(height: 15),
            PasswordTextField(
              controller: pwdController,
              hintText: "Password",
            ),
            const SizedBox(height: 15),
            PasswordTextField(
              controller: confirmPwdController,
              hintText: "Confirm Password",
            ),
            const SizedBox(height: 30),
            CustomButton(isBlack: true, label: "Sign up", onPressed: () {}),
            const SizedBox(height: 30),
            Text(
              "or continue with",
              style: TextStyleConstants.smallText,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtherPlatformButton(
                  logoPath: 'assets/google.svg',
                  onTap: () {},
                ),
                OtherPlatformButton(
                  logoPath: 'assets/facebook.svg',
                  onTap: () {},
                ),
                OtherPlatformButton(
                  logoPath: 'assets/twitter.svg',
                  onTap: () {},
                )
              ],
            ),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                text: "Already have an account? ",
                style: TextStyleConstants.smallText
                    .copyWith(fontWeight: FontWeight.w300),
                children: [
                  TextSpan(
                    text: 'Login',
                    style: TextStyleConstants.smallText,
                    recognizer: loginOnTap,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
