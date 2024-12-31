import 'package:flutter/material.dart';
import 'package:furnify/constants/textstyle_constants.dart';

class PlaceholderWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const PlaceholderWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 100),
          Icon(
            icon,
            size: 150,
            weight: 500,
          ),
          Text(
            title,
            style: TextStyleConstants.titleMedium,
          ),
        ],
      ),
    );
  }
}
