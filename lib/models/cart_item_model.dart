class ItemModel {
  final String productId;
  final String productName;
  final String productCompany;
  final double productPrize;
  final String productImageUrl;
  final int quantity;

  ItemModel({
    required this.productId,
    required this.productName,
    required this.productCompany,
    required this.productPrize,
    required this.productImageUrl,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': productId,
      'name': productName,
      'company': productCompany,
      'prize': productPrize,
      'imageUrl': productImageUrl,
      'quantity': quantity,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      productId: map['id'],
      productName: map['name'],
      productCompany: map['company'],
      productPrize: map['prize'],
      productImageUrl: map['imageUrl'],
      quantity: map['quantity'],
    );
  }

  @override
  String toString() {
    return 'ItemModel(productId: $productId, productName: $productName, productCompany: $productCompany, productPrize: $productPrize, productImageUrl: $productImageUrl, quantity: $quantity)';
  }
}
