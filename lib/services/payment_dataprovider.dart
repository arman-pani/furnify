import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furnify/models/receipt_model.dart';
import 'package:http/http.dart' as http;

class PaymentDataProvider {
  static const String baseUrl =
      "https://us-central1-furnifyapp.cloudfunctions.net/api";
  static Future<String> getOrderIdForPayment({
    required int amount,
    required Map notes,
  }) async {
    const url = '$baseUrl/payments/create-order';
    debugPrint('Payment OrderId URL: $url');

    final requestBody = {
      'amount': amount,
      'currency': 'INR',
      'notes': notes,
    };
    debugPrint('Request body: $requestBody');

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );

    debugPrint('Response: ${jsonEncode(response.body)}');

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      // only return the orderId
      return responseBody['orderId'];
    } else {
      throw Exception('Failed to create orderId: ${response.reasonPhrase}');
    }
  }

  static Future<Map<String, dynamic>> verifyAndSavePaymentReceipt(
      {required ReceiptModel paymentReceipt}) async {
    const url = '$baseUrl/payments/payment-success';
    debugPrint('Payment Success URL: $url');

    final requestBody = paymentReceipt.toMap();
    debugPrint('Request body: $requestBody');

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );

    debugPrint('Response: ${jsonEncode(response.body)}');

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      return responseBody;
    } else {
      throw Exception('Failed to verify the payment: ${response.reasonPhrase}');
    }
  }
}
