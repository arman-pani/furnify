import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:furnify/app_router.dart';
import 'package:furnify/models/receipt_model.dart';
import 'package:furnify/models/user_model.dart';
import 'package:furnify/services/common_methods.dart';
import 'package:furnify/services/payment_dataprovider.dart';
import 'package:furnify/utils/show_snackbar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentMethods {
  late Razorpay _razorpay;

  final BuildContext context;

  PaymentMethods(this.context) {
    _razorpay = Razorpay();
    _initializeListeners();
  }

  void _initializeListeners() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWalletSelected);
  }

  void openCheckout({
    // remember the amount will be in Paise
    required int amount,
    required String description,
  }) async {
    try {
      final orderId = await PaymentDataProvider.getOrderIdForPayment(
        amount: amount,
        notes: {},
      );
      debugPrint('OrderId: $orderId');

      const String companyName = "Furnify";
      const String currency = 'INR';

      String razorPayKeyId = dotenv.env['RAZORPAY_KEY_ID']!;
      UserModel? userInfo = await getUserFromPrefs();

      // remember the amount will be in Paise
      var options = {
        'key': razorPayKeyId,
        'amount': amount,
        'currency': currency,
        'name': companyName,
        'description': description,
        'order_id': orderId,
        'prefill': {
          'name': '${userInfo.firstName} ${userInfo.lastName}',
          'contact': userInfo.phoneNumber,
        },
      };

      _razorpay.open(options);
    } catch (e) {
      debugPrint("Error: $e");
      showSnackBar(context: context, text: e.toString());
    }
  }

  void _handlePaymentErrorResponse(PaymentFailureResponse response) {
    debugPrint("Payment Failed: ${response.message}");

    showSnackBar(context: context, text: response.message!);
  }

  void _handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    debugPrint("PaymentId: ${response.paymentId}");
    debugPrint("OrderId: ${response.orderId}");
    debugPrint("Signature: ${response.signature}");

    final paymentReceipt = ReceiptModel(
      razorpayPaymentId: response.paymentId!,
      razorpayOrderId: response.orderId!,
      razorpaySignature: response.signature!,
    );

    final verificationResponse =
        await PaymentDataProvider.verifyAndSavePaymentReceipt(
            paymentReceipt: paymentReceipt);

    Navigator.of(context).push(AppRouter.orderConfirmedPage());

    showSnackBar(
      context: context,
      text: "Payment Success: $verificationResponse",
    );
  }

  void _handleExternalWalletSelected(ExternalWalletResponse response) {
    debugPrint("External Wallet Selected: ${response.walletName}");
    // Customize the behavior based on your app requirements.
  }

  void dispose() {
    _razorpay.clear();
  }
}
