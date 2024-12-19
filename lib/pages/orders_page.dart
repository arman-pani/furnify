import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furnify/constants/textstyle_constants.dart';
import 'package:furnify/models/order_model.dart';
import 'package:furnify/riverpod/order_notifier.dart';
import 'package:furnify/widgets/custom_appbar.dart';
import 'package:furnify/widgets/order_card.dart';
import 'package:material_symbols_icons/symbols.dart';

class OrdersPage extends ConsumerStatefulWidget {
  const OrdersPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<OrdersPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<OrdersPage> {
  late TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final List<OrderModel> orders = ref.watch(ordersProvider);

    final List<OrderModel> ongoingOrders =
        orders.where((order) => !order.isDelivered).toList();

    final List<OrderModel> completedOrders =
        orders.where((order) => order.isDelivered).toList();

    return Scaffold(
      appBar: homeAppBar(
        context: context,
        bottom: TabBar(
          controller: _tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          labelColor: Colors.black,
          labelStyle: TextStyleConstants.tabLabel,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: "Ongoing"),
            Tab(text: "Completed"),
          ],
        ),
        leading: Row(
          children: [
            const SizedBox(width: 15),
            const Icon(
              Symbols.package_2_rounded,
              size: 30,
              weight: 600,
            ),
            const SizedBox(width: 10),
            Text(
              "My Orders",
              style: TextStyleConstants.appBar,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          orderListView(orders: ongoingOrders),
          orderListView(orders: completedOrders),
        ],
      ),
    );
  }

  Widget orderListView({required List<OrderModel> orders}) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      clipBehavior: Clip.none,
      scrollDirection: Axis.vertical,
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final OrderModel order = orders[index];
        return OrderCard(order: order);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 15),
    );
  }
}
