import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnify/models/product_model.dart';
import 'package:furnify/sqlflite/local_database_helper.dart';

class WishlistNotifier extends StateNotifier<List<ProductModel>> {
  final LocalDatabaseHelper db;

  WishlistNotifier(this.db) : super([]) {
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    state = await db.getWishlist();
  }

  Future<void> addToWishlist({required ProductModel product}) async {
    await db.addToWishlist(product);
    state = [...state, product];
  }

  Future<void> removeFromWishlist({required String productId}) async {
    await db.removeFromWishlist(productId);
    state = state.where((item) => item.id != productId).toList();
  }

  bool isInWishlist(String productId) {
    return state.any((product) => product.id == productId);
  }
}

final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, List<ProductModel>>((ref) {
  return WishlistNotifier(LocalDatabaseHelper());
});
