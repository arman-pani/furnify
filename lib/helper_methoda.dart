import 'package:furnify/models/billing_model.dart';

double calculateGrandTotal(List<BillingModel> billingItems) {
  double total = 0.0;

  for (var item in billingItems) {
    total += item.amount;
  }

  return total;
}
