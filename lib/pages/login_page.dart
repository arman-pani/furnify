import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/widgets/custom_button.dart';
import 'package:furnify/widgets/custom_textfield.dart';
import 'package:furnify/widgets/other_platform_button.dart';
import 'package:furnify/widgets/pwd_textfield.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  final TapGestureRecognizer signUpOnTap = TapGestureRecognizer()
    ..onTap = () {
      print('Tapped on clickable text!');
      // Perform your action here
    };

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

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
                "Hello Again!",
                style: TextStyleConstants.titleLarge,
              ),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              controller: emailController,
              hintText: "Email Address",
              prefixIcon: Symbols.email_rounded,
            ),
            const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PasswordTextField(
                  controller: pwdController,
                  hintText: "Password",
                ),
                const SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    text: 'Forget Password?',
                    style: TextStyleConstants.smallText,
                    recognizer: signUpOnTap,
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            CustomButton(
              isBlack: true,
              label: "Login",
              onPressed: () {},
            ),
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
                text: "Don't have an account? ",
                style: TextStyleConstants.smallText
                    .copyWith(fontWeight: FontWeight.w300),
                children: [
                  TextSpan(
                    text: 'Sign up',
                    style: TextStyleConstants.smallText,
                    recognizer: signUpOnTap,
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
