import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnify/app_router.dart';
import 'package:furnify/widgets/custom_appbar.dart';
import 'package:furnify/widgets/settings_section.dart';
import 'package:material_symbols_icons/symbols.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: 'Account Settings', context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SettingsSection(
              settingsRows: [
                SettingsRow(
                  label: 'Change Password',
                  icon: Symbols.lock_clock_rounded,
                  onTap: () => Navigator.of(context)
                      .push(AppRouter.forgetPasswordPage()),
                ),
                SettingsRow(
                  label: 'Log out',
                  icon: Symbols.logout_rounded,
                  onTap: () {
                    setState(() {
                      FirebaseAuth.instance.signOut();
                    });
                  },
                ),
                SettingsRow(
                  label: 'Delete Account',
                  icon: Symbols.delete_forever_rounded,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
