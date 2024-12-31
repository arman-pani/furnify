import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furnify/models/order_model.dart';
import 'package:furnify/models/user_model.dart';

class FirestoreMethods {
  static Future<String> postOrderToFirestore(
      OrderModel order, UserModel user) async {
    try {
      final ordersCollection = FirebaseFirestore.instance.collection('orders');

      final orderMap = order.toJsonForOrdersCollection(user);

      DocumentReference docRef = await ordersCollection.add(orderMap);

      return docRef.id;
    } catch (error) {
      debugPrint(error.toString());
      throw Exception('Error posting order to firestore: $error');
    }
  }
}
