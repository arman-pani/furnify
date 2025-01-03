import 'package:flutter/material.dart';
import 'package:furnify/app_router.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/widgets/custom_button.dart';
import 'package:material_symbols_icons/symbols.dart';

class OrderConfirmedPage extends StatelessWidget {
  const OrderConfirmedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 200),
              const Icon(
                Symbols.order_approve_rounded,
                size: 150,
                weight: 500,
              ),
              Text(
                "Order is confirmed!",
                style: TextStyleConstants.titleMedium,
              ),
              const Spacer(),
              CustomButton(
                label: 'Done',
                onPressed: () {
                  Navigator.of(context).popUntil((route) =>
                      route.settings.name ==
                      AppRouter.indexPage().settings.name);
                },
                isBlack: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
