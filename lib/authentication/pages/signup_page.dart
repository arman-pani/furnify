import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:furnify/app_router.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/services/firebase_auth_methods.dart';
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

  void signUpUserWithEmail() async {
    FirebaseAuthMethods(
      FirebaseAuth.instance,
      FirebaseFirestore.instance,
    ).signUpWithEmail(
      email: emailController.text.trim(),
      password: pwdController.text.trim(),
      context: context,
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    pwdController.dispose();
    confirmPwdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TapGestureRecognizer loginOnTap = TapGestureRecognizer()
      ..onTap = () => Navigator.of(context).push(AppRouter.logInPage());

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            CustomButton(
              isBlack: true,
              label: "Sign up",
              onPressed: signUpUserWithEmail,
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
                  onTap: () {
                    FirebaseAuthMethods(
                      FirebaseAuth.instance,
                      FirebaseFirestore.instance,
                    ).signInWithGoogle(context);
                  },
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
