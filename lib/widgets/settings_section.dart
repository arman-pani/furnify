import 'package:flutter/material.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/constants/theme_constants.dart';
import 'package:material_symbols_icons/symbols.dart';

class SettingsRow {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  SettingsRow({
    required this.label,
    required this.icon,
    required this.onTap,
  });
}

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    this.title,
    required this.settingsRows,
  });

  final String? title;
  final List<SettingsRow> settingsRows;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
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
            itemBuilder: (context, index) {
              final SettingsRow row = settingsRows[index];
              return settingsRow(
                label: row.label,
                icon: row.icon,
                onTap: row.onTap,
              );
            },
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
