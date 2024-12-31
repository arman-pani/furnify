// class OrdersNotifier extends StateNotifier<List<OrderModel>> {
//   final LocalDatabaseHelper db;

//   OrdersNotifier(this.db) : super([]) {
//     _loadOrders();
//   }

//   Future<void> _loadOrders() async {
//     final orders = await db.getOrdersFromLocalDB();
//     state = orders;
//   }

//   Future<void> addOrder(OrderModel order) async {
//     await db.addToOrders(order: order);
//     state = [...state, order];
//   }
// }

// final ordersProvider = StateNotifierProvider<OrdersNotifier, List<OrderModel>>(
//   (ref) => OrdersNotifier(LocalDatabaseHelper()),
// );
