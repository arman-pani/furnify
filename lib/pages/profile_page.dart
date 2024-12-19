import 'package:flutter/material.dart';
import 'package:furnify/constants/color_constants.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/constants/theme_constants.dart';
import 'package:furnify/widgets/custom_appbar.dart';
import 'package:material_symbols_icons/symbols.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                CircleAvatar(
                  radius: 45,
                  backgroundColor: ColorConstants.primaryColor,
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Arman Pani',
                      style: TextStyleConstants.titleMedium,
                    ),
                    Text(
                      "+91 70080 17866",
                      style: TextStyleConstants.orderDeliveryDate,
                    )
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Symbols.edit_rounded,
                    size: 30,
                    weight: 600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            settingsSection(
              title: 'Manage',
              settingsRows: [
                settingsRow(
                  label: 'Your Addresses',
                  icon: Symbols.file_map_stack_rounded,
                  onTap: () {},
                ),
                settingsRow(
                  label: 'Order Transactions',
                  icon: Symbols.receipt_long_rounded,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 30),
            settingsSection(
              title: 'Support',
              settingsRows: [
                settingsRow(
                  label: 'Help Center',
                  icon: Symbols.help_center_rounded,
                  onTap: () {},
                ),
                settingsRow(
                  label: 'Share Feedback',
                  icon: Symbols.forum_rounded,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 30),
            settingsSection(
              title: 'More',
              settingsRows: [
                settingsRow(
                  label: 'About Us',
                  icon: Symbols.group_work_rounded,
                  onTap: () {},
                ),
                settingsRow(
                  label: 'Account Seetings',
                  icon: Symbols.settings_rounded,
                  onTap: () {},
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

  Widget settingsSection({
    required String title,
    required List<Widget> settingsRows,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyleConstants.titleMedium,
        ),
        const SizedBox(height: 15),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: ThemeConstants.greyBoxDecoration,
          child: ListView.separated(
            itemCount: settingsRows.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => settingsRows[index],
            separatorBuilder: (context, index) => const SizedBox(height: 15),
          ),
        )
      ],
    );
  }

  Widget settingsRow({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            weight: 600,
            size: 30,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyleConstants.settingsLabel,
          ),
          const Spacer(),
          const Icon(
            Symbols.arrow_forward_ios_rounded,
            weight: 600,
            size: 25,
          ),
        ],
      ),
    );
  }
}
