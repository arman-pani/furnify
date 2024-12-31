import 'package:flutter/material.dart';
import 'package:furnify/authentication/pages/email_verification_page.dart';
import 'package:furnify/authentication/pages/forget_password_page.dart';
import 'package:furnify/authentication/pages/login_page.dart';
import 'package:furnify/authentication/pages/reset_password.dart';
import 'package:furnify/authentication/pages/setup_profile_page.dart';
import 'package:furnify/authentication/pages/signup_page.dart';
import 'package:furnify/index.dart';
import 'package:furnify/models/cart_item_model.dart';
import 'package:furnify/models/order_model.dart';
import 'package:furnify/models/product_model.dart';
import 'package:furnify/pages/account_settings_page.dart';
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

  static MaterialPageRoute logInPage() {
    return MaterialPageRoute(
      builder: (context) => const LoginPage(),
    );
  }

  static MaterialPageRoute signUpPage() {
    return MaterialPageRoute(
      builder: (context) => const SignupPage(),
    );
  }

  static MaterialPageRoute indexPage() {
    return MaterialPageRoute(
      builder: (context) => const IndexPage(),
    );
  }

  static MaterialPageRoute setupProfilePage() {
    return MaterialPageRoute(
      builder: (context) => const SetupProfilePage(),
    );
  }

  static MaterialPageRoute forgetPasswordPage() {
    return MaterialPageRoute(
      builder: (context) => const ForgetPasswordPage(),
    );
  }

  static MaterialPageRoute emailVerificationPage() {
    return MaterialPageRoute(
      builder: (context) => const EmailVerificationPage(),
    );
  }

  static MaterialPageRoute resetPasswordPage() {
    return MaterialPageRoute(
      builder: (context) => const ResetPasswordPage(),
    );
  }

  static MaterialPageRoute accountSettingsPage() {
    return MaterialPageRoute(
      builder: (context) => const AccountSettingsPage(),
    );
  }
}
