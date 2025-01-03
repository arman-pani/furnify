import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnify/models/cart_item_model.dart';
import 'package:furnify/sqlflite/local_database_helper.dart';

class CartNotifier extends StateNotifier<List<ItemModel>> {
  final LocalDatabaseHelper _databaseHelper;

  CartNotifier(this._databaseHelper) : super([]) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    state = await _databaseHelper.getCart();
  }

  Future<void> addToCart({required ItemModel cartItem}) async {
    List<ItemModel> currentCart = state;

    // Find if the item with the same productId already exists in the cart
    final existingItemIndex =
        currentCart.indexWhere((item) => item.productId == cartItem.productId);

    if (existingItemIndex != -1) {
      // If item exists, update the quantity by adding the new quantity to the old quantity
      int newQuantity =
          currentCart[existingItemIndex].quantity + cartItem.quantity;

      await updateQuantity(
        productId: cartItem.productId,
        newQuantity: newQuantity,
      );
    } else {
      // If the item doesn't exist, add the new cart item to the cart list
      await _databaseHelper.addToNewCartItemToDB(cartItem: cartItem);
    }

    // Save the updated cart state
    state = await _databaseHelper.getCart();
  }

  Future<void> clearCart() async {
    await _databaseHelper.deleteAllCartItems();
    state = [];
  }

  Future<void> removeFromCart({required String productId}) async {
    await _databaseHelper.removeFromCart(productId: productId);
    state = await _databaseHelper.getCart();
  }

  Future<void> updateQuantity({
    required String productId,
    required int newQuantity,
  }) async {
    await _databaseHelper.updateQuantity(
        productId: productId, newQuantity: newQuantity);
    state = await _databaseHelper.getCart();
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<ItemModel>>(
  (ref) => CartNotifier(LocalDatabaseHelper()),
);
