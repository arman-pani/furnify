import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OtherPlatformButton extends StatelessWidget {
  final String logoPath;
  final VoidCallback onTap;
  const OtherPlatformButton({
    super.key,
    required this.logoPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        logoPath,
        height: 60,
        width: 60,
      ),
    );
  }
}
