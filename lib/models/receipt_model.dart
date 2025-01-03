class ReceiptModel {
  final String razorpayPaymentId;
  final String razorpayOrderId;
  final String razorpaySignature;

  ReceiptModel({
    required this.razorpayPaymentId,
    required this.razorpayOrderId,
    required this.razorpaySignature,
  });

  Map<String, dynamic> toMap() {
    return {
      'razorpay_payment_id': razorpayPaymentId,
      'razorpay_order_id': razorpayOrderId,
      'razorpay_signature': razorpaySignature,
    };
  }
}
