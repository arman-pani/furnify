import 'package:flutter/material.dart';
import 'package:furnify/app_router.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:material_symbols_icons/symbols.dart';

PreferredSizeWidget customAppBar({
  required String title,
  List<Widget>? actions,
  required BuildContext context,
}) {
  return AppBar(
    leading: GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: const Icon(
        Symbols.arrow_back_rounded,
        weight: 600,
        size: 30,
      ),
    ),
    surfaceTintColor: Colors.white,
    backgroundColor: Colors.white,
    titleSpacing: 0,
    title: Text(
      title,
      style: TextStyleConstants.appBar,
    ),
    actionsIconTheme: const IconThemeData(
      size: 25,
      color: Colors.black,
      weight: 600,
    ),
    actions: [
      ...?actions,
      const SizedBox(width: 15),
    ],
  );
}

PreferredSizeWidget homeAppBar(
    {required Widget leading,
    PreferredSizeWidget? bottom,
    required BuildContext context}) {
  return AppBar(
    leading: leading,
    bottom: bottom,
    leadingWidth: double.infinity,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    actions: [
      GestureDetector(
        onTap: () => Navigator.of(context).push(AppRouter.wishListPage()),
        child: const Icon(
          Symbols.favorite_border_rounded,
          size: 25,
          weight: 600,
        ),
      ),
      const SizedBox(width: 10),
      GestureDetector(
        onTap: () => Navigator.of(context).push(AppRouter.profilePage()),
        child: const Icon(
          Symbols.account_circle_rounded,
          size: 25,
          weight: 600,
        ),
      ),
      const SizedBox(width: 15),
    ],
    titleSpacing: 0,
  );
}
