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
import 'package:material_symbols_icons/material_symbols_icons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  void loginUserWithEmail() async {
    FirebaseAuthMethods(
      FirebaseAuth.instance,
      FirebaseFirestore.instance,
    ).loginWithEmail(
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
  }

  @override
  Widget build(BuildContext context) {
    final TapGestureRecognizer signUpOnTap = TapGestureRecognizer()
      ..onTap = () => Navigator.of(context).push(AppRouter.signUpPage());

    final TapGestureRecognizer forgetPwdOnTap = TapGestureRecognizer()
      ..onTap =
          () => Navigator.of(context).push(AppRouter.forgetPasswordPage());
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
                    recognizer: forgetPwdOnTap,
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            CustomButton(
              isBlack: true,
              label: "Login",
              onPressed: loginUserWithEmail,
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
