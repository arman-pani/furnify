import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnify/models/order_model.dart';
import 'package:furnify/models/product_model.dart';
import 'package:furnify/models/user_model.dart';
import 'package:furnify/services/firestore_methods.dart';
import 'package:furnify/services/payment_methods.dart';
import 'package:furnify/sqlflite/local_database_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpod_provider.g.dart';

@riverpod
Future<List<ProductModel>> getTrendingProducts(Ref ref) async {
  try {
    final productsCollection =
        FirebaseFirestore.instance.collection('products');

    final productsSnapshot = await productsCollection.get();

    final products = productsSnapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data(), doc.id))
        .toList();

    debugPrint("Products: $products");

    return products;
  } catch (error) {
    debugPrint(error.toString());
    throw Exception('Error fetching trending products from firestore: $error');
  }
}

@riverpod
Future<List<ProductModel>> getCategoryProducts(Ref ref, String category) async {
  try {
    final productsCollection =
        FirebaseFirestore.instance.collection('products');

    final productsSnapshot =
        await productsCollection.where('category', isEqualTo: category).get();
    final catergoryProducts = productsSnapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data(), doc.id))
        .toList();

    return catergoryProducts;
  } catch (error) {
    debugPrint(error.toString());
    throw Exception('Error fetching category products from firestore: $error');
  }
}

@riverpod
class OrderNotifier extends _$OrderNotifier {
  @override
  Future<List<OrderModel>> build() async => [...await getOrdersFromLocalDb()];

  Future<List<OrderModel>> getOrdersFromLocalDb() async {
    final LocalDatabaseHelper localDB = LocalDatabaseHelper();
    final orders = await localDB.getOrdersFromLocalDB();
    return orders;
  }

  Future<void> addOrder(
    OrderModel order,
    UserModel user,
    BuildContext context,
  ) async {
    try {
      int amount = (order.totalPrize * 100).toInt();
      PaymentMethods(context).openCheckout(
        amount: amount,
        description: '',
      );
      final docId = await FirestoreMethods.postOrderToFirestore(order, user);

      final newOrder = order.copyWith(id: docId);

      final LocalDatabaseHelper localDB = LocalDatabaseHelper();
      await localDB.addToOrders(order: newOrder);

      final previousState = await future;
      state = AsyncData([...previousState, order]);
    } catch (error) {
      debugPrint(error.toString());
      throw Exception('Error posting order to local database: $error');
    }
  }
}
