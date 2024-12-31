import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnify/app_router.dart';
import 'package:furnify/services/firebase_auth_methods.dart';
import 'package:furnify/widgets/custom_appbar.dart';
import 'package:furnify/widgets/custom_button.dart';
import 'package:furnify/widgets/custom_textfield.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class SetupProfilePage extends StatefulWidget {
  const SetupProfilePage({super.key});

  @override
  State<SetupProfilePage> createState() => _SetupProfilePageState();
}

class _SetupProfilePageState extends State<SetupProfilePage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  Avatar avatar = DiceBearBuilder.withRandomSeed(
    sprite: DiceBearSprite.openPeeps,
    radius: 10,
    backgroundColor: Colors.black,
    size: 10,
  ).build();

  void setupProfile() async {
    Uint8List? rawProfileImage = await avatar.asRawSvgBytes();

    FirebaseAuthMethods(
      FirebaseAuth.instance,
      FirebaseFirestore.instance,
    ).saveUserProfile(
      context: context,
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      profileImage: rawProfileImage!,
      phoneNumber: phoneNumberController.text.trim(),
    );

    Navigator.of(context).push(AppRouter.indexPage());
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget profileImage = avatar.toImage();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(
        title: "Setup Profile",
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              width: 200,
              height: 200,
              child: profileImage,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              controller: firstNameController,
              hintText: "First Name",
              prefixIcon: Symbols.person_rounded,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              controller: lastNameController,
              hintText: "Last Name",
              prefixIcon: Symbols.person_rounded,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              controller: phoneNumberController,
              hintText: "Phone Number",
              prefixIcon: Symbols.phone_rounded,
            ),
            const SizedBox(height: 25),
            CustomButton(
              isBlack: true,
              label: "Create account",
              onPressed: setupProfile,
            )
          ],
        ),
      ),
    );
  }
}
