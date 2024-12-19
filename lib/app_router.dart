import 'package:flutter/material.dart';
import 'package:furnify/models/cart_item_model.dart';
import 'package:furnify/models/order_model.dart';
import 'package:furnify/models/product_model.dart';
import 'package:furnify/pages/category_page.dart';
import 'package:furnify/pages/checkout_page.dart';
import 'package:furnify/pages/order_confirmed.dart';
import 'package:furnify/pages/order_receipt_page.dart';
import 'package:furnify/pages/product_page.dart';
import 'package:furnify/pages/profile_page.dart';
import 'package:furnify/pages/shipping_address_page.dart';
import 'package:furnify/pages/wishlist_page.dart';

class AppRouter {
  static MaterialPageRoute productPage({required ProductModel product}) {
    return MaterialPageRoute(
      builder: (context) => ProductPage(product: product),
    );
  }

  static MaterialPageRoute catergoryPage({required String category}) {
    return MaterialPageRoute(
      builder: (context) => CategoryPage(category: category),
    );
  }

  static MaterialPageRoute checkoutPage({required List<ItemModel> cartItems}) {
    return MaterialPageRoute(
      builder: (context) => CheckoutPage(cartItems: cartItems),
    );
  }

  static MaterialPageRoute shippingAddressPage() {
    return MaterialPageRoute(
      builder: (context) => const ShippingAddressPage(),
    );
  }

  static MaterialPageRoute orderReceiptPage({required OrderModel order}) {
    return MaterialPageRoute(
      builder: (context) => OrderReceiptPage(order: order),
    );
  }

  static MaterialPageRoute wishListPage() {
    return MaterialPageRoute(
      builder: (context) => const WishListPage(),
    );
  }

  static MaterialPageRoute orderConfirmedPage() {
    return MaterialPageRoute(
      builder: (context) => const OrderConfirmedPage(),
    );
  }

  static MaterialPageRoute profilePage() {
    return MaterialPageRoute(
      builder: (context) => const ProfilePage(),
    );
  }
}
