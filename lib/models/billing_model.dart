class BillingModel {
  final String title;
  final double amount;

  BillingModel({required this.title, required this.amount});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
    };
  }

  factory BillingModel.fromMap(Map<String, dynamic> map) {
    return BillingModel(
      title: map['title'] as String,
      amount: map['amount'] as double,
    );
  }
}
