import 'package:flutter/material.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/widgets/custom_button.dart';
import 'package:material_symbols_icons/symbols.dart';

class OrderConfirmedPage extends StatelessWidget {
  const OrderConfirmedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Navigator.popUntil(
                      context, ModalRoute.withName('/indexPage'));
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
