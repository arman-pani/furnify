import 'dart:convert';

import 'package:furnify/models/address_model.dart';
import 'package:furnify/models/billing_model.dart';
import 'package:furnify/models/cart_item_model.dart';
import 'package:uuid/uuid.dart';

class OrderModel {
  final String id;
  final double totalPrize;
  final List<BillingModel> billingDetails;
  final List<ItemModel> itemList;
  final bool isDelivered;
  final DateTime deliveryDate;
  final DateTime orderDateTime;
  final AddressModel shippingAddress;

  OrderModel({
    String? id,
    required this.totalPrize,
    required this.billingDetails,
    required this.itemList,
    required this.isDelivered,
    required this.deliveryDate,
    required this.orderDateTime,
    required this.shippingAddress,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'totalPrize': totalPrize,
      'billingDetails':
          jsonEncode(billingDetails.map((bill) => bill.toMap()).toList()),
      'itemList': jsonEncode(itemList.map((item) => item.toMap()).toList()),
      'isDelivered': isDelivered ? 1 : 0,
      'deliveryDate': deliveryDate.toIso8601String(),
      'orderDateTime': orderDateTime.toIso8601String(),
      'shippingAddress': jsonEncode(shippingAddress.toMap()),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      totalPrize: map['totalPrize'] as double,
      billingDetails: List<BillingModel>.from(
        (jsonDecode(map['billingDetails']) as List).map(
          (bill) => BillingModel.fromMap(bill),
        ),
      ),
      itemList: List<ItemModel>.from(
        (jsonDecode(map['itemList']) as List).map(
          (item) => ItemModel.fromMap(item),
        ),
      ),
      isDelivered: map['isDelivered'] == 1,
      deliveryDate: DateTime.parse(map['deliveryDate']),
      orderDateTime: DateTime.parse(map['orderDateTime']),
      shippingAddress: AddressModel.fromMap(
        jsonDecode(map['shippingAddress']),
      ),
    );
  }
}
