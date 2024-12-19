import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Setup Profile",
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const Icon(
              Symbols.account_box_rounded,
              size: 200,
              weight: 300,
            ),
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
              controller: firstNameController,
              hintText: "Phone Number",
              prefixIcon: Symbols.phone_rounded,
            ),
            const SizedBox(height: 25),
            CustomButton(
                isBlack: true, label: "Create account", onPressed: () {})
          ],
        ),
      ),
    );
  }
}
