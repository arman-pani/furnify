import 'package:furnify/models/address_model.dart';
import 'package:furnify/models/cart_item_model.dart';
import 'package:furnify/models/order_model.dart';
import 'package:furnify/models/product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseHelper {
  static final LocalDatabaseHelper _instance = LocalDatabaseHelper._internal();
  static Database? _database;

  factory LocalDatabaseHelper() => _instance;

  LocalDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'furnify.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // // Generic Insert Method
  // Future<void> insert(String table, Map<String, dynamic> data) async {
  //   final db = await database;
  //   await db.insert(
  //     table,
  //     data,
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  // // Generic Delete Method
  // Future<void> delete(String table, String where, List<dynamic> whereArgs) async {
  //   final db = await database;
  //   await db.delete(table, where: where, whereArgs: whereArgs);
  // }

  // // Generic Query Method
  // Future<List<Map<String, dynamic>>> query(String table,
  //     {String? where, List<dynamic>? whereArgs}) async {
  //   final db = await database;
  //   return db.query(table, where: where, whereArgs: whereArgs);
  // }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add 'category' column to the wishlist table in version 2
      await db.execute('''
      ALTER TABLE wishlist ADD COLUMN category TEXT;
    ''');
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE wishlist (
        id TEXT PRIMARY KEY NOT NULL,
        name TEXT NOT NULL,
        company TEXT NOT NULL,
        category TEXT NOT NULL,
        description TEXT NOT NULL,
        prize REAL NOT NULL,
        rating REAL NOT NULL,
        imageUrlList TEXT NOT NULL,
        glbModelUrl TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE cart (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        company TEXT NOT NULL,
        prize REAL NOT NULL,
        imageUrl TEXT NOT NULL,
        quantity INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE orders (
        id TEXT PRIMARY KEY,
        totalPrize REAL NOT NULL,
        billingDetails TEXT NOT NULL,
        itemList TEXT NOT NULL,
        isDelivered INTEGER NOT NULL,
        deliveryDate TEXT NOT NULL,
        orderDateTime TEXT NOT NULL,
        shippingAddress TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE addresses (
        id TEXT PRIMARY KEY,
        isDefault INTEGER NOT NULL,
        tag TEXT NOT NULL,
        address1 TEXT NOT NULL,
        address2 TEXT,
        pincode INTEGER NOT NULL,
        country TEXT NOT NULL,
        state TEXT NOT NULL,
        district TEXT NOT NULL
      )
    ''');
  }

  // WISHLIST METHODS

  Future<void> addToWishlist(ProductModel product) async {
    final db = await database;

    await db.insert(
      'wishlist',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ProductModel>> getWishlist() async {
    final db = await database;
    final result = await db.query('wishlist');

    return result.map((json) => ProductModel.fromMap(json)).toList();
  }

  Future<void> removeFromWishlist(String productId) async {
    final db = await database;

    await db.delete(
      'wishlist',
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  // CART METHODS

  Future<void> addToNewCartItemToDB({required ItemModel cartItem}) async {
    final db = await database;

    await db.insert(
      'cart',
      cartItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ItemModel>> getCart() async {
    final db = await database;
    final result = await db.query('cart');

    return result.map((json) => ItemModel.fromMap(json)).toList();
  }

  Future<void> removeFromCart({required String productId}) async {
    final db = await database;

    await db.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  Future<void> deleteAllCartItems() async {
    final db = await database;

    await db.delete('cart');
  }

  Future<void> updateQuantity({
    required String productId,
    required int newQuantity,
  }) async {
    final db = await database;

    await db.update(
      'cart',
      {'quantity': newQuantity},
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  // ORDERS METHODS

  Future<void> addToOrders({required OrderModel order}) async {
    final db = await database;

    await db.insert(
      'orders',
      order.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<OrderModel>> getOrdersFromLocalDB() async {
    final db = await database;
    final result = await db.query('orders');

    return result.map((json) => OrderModel.fromMap(json)).toList();
  }

  // ADDRESSES METHODS

  Future<void> addAddressToLocalDB({required AddressModel address}) async {
    final db = await database;

    await db.insert(
      'addresses',
      address.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<AddressModel>> getAddressesFromLocalDB() async {
    final db = await database;
    final result = await db.query('addresses');

    return result.map((json) => AddressModel.fromMap(json)).toList();
  }

  Future<void> updateAddressInLocalDB({required AddressModel address}) async {
    final db = await database;

    await db.update(
      'addresses',
      address.toMap(),
      where: 'id = ?',
      whereArgs: [address.id],
    );
  }

  Future<AddressModel?> getDefaultAddress() async {
    final db = await database;

    final result = await db.query(
      'addresses',
      where: 'isDefault = ?',
      whereArgs: [1],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return AddressModel.fromMap(result.first);
    }
    return null;
  }

  Future<void> setDefaultAddress(String addressId) async {
    final db = await database;

    final batch = db.batch();

    batch.update(
      'addresses',
      {'isDefault': 0},
    );

    batch.update(
      'addresses',
      {'isDefault': 1},
      where: 'id = ?',
      whereArgs: [addressId],
    );

    await batch.commit(noResult: true);
  }
}
