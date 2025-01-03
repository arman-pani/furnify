import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furnify/app_router.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/models/user_model.dart';
import 'package:furnify/services/common_methods.dart';
import 'package:furnify/widgets/custom_appbar.dart';
import 'package:furnify/widgets/settings_section.dart';
import 'package:material_symbols_icons/symbols.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel userInfo = UserModel(
    firstName: '',
    lastName: '',
    phoneNumber: '',
    profileImage: Uint8List(0),
    id: '',
    createdAt: DateTime.now(),
  );

  @override
  void initState() {
    super.initState();
    getUserFromPrefs().then((value) {
      setState(() {
        userInfo = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        title: 'Profile',
        context: context,
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(right: 15, left: 15, bottom: 30, top: 15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black,
                  ),
                  width: 75,
                  height: 75,
                  child: SvgPicture.memory(
                    userInfo.profileImage,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${userInfo.firstName} ${userInfo.lastName}",
                      style: TextStyleConstants.titleMedium,
                    ),
                    Text(
                      userInfo.phoneNumber,
                      style: TextStyleConstants.orderDeliveryDate,
                    )
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(AppRouter.setupProfilePage(userInfo)),
                  child: const Icon(
                    Symbols.edit_rounded,
                    size: 30,
                    weight: 600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SettingsSection(title: 'Manage', settingsRows: [
              SettingsRow(
                label: 'Your Addresses',
                icon: Symbols.file_map_stack_rounded,
                onTap: () =>
                    Navigator.of(context).push(AppRouter.shippingAddressPage()),
              ),
              SettingsRow(
                label: 'Order Transactions',
                icon: Symbols.receipt_long_rounded,
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 30),
            SettingsSection(title: 'Support', settingsRows: [
              SettingsRow(
                label: 'Help Center',
                icon: Symbols.help_center_rounded,
                onTap: () {},
              ),
              SettingsRow(
                label: 'Share Feedback',
                icon: Symbols.forum_rounded,
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 30),
            SettingsSection(
              title: 'More',
              settingsRows: [
                SettingsRow(
                  label: 'About Us',
                  icon: Symbols.group_work_rounded,
                  onTap: () {},
                ),
                SettingsRow(
                  label: 'Account Settings',
                  icon: Symbols.settings_rounded,
                  onTap: () => Navigator.of(context)
                      .push(AppRouter.accountSettingsPage()),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Symbols.chair_rounded,
                      weight: 700,
                      size: 45,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Furnify',
                      style: TextStyleConstants.titleMedium,
                    ),
                  ],
                ),
                Text(
                  'v1.0.0',
                  style: TextStyleConstants.smallText.copyWith(
                    height: 0.35,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
