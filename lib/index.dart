import 'package:flutter/material.dart';
import 'package:furnify/pages/cart_page.dart';
import 'package:furnify/pages/explore_page.dart';
import 'package:furnify/pages/orders_page.dart';
import 'package:material_symbols_icons/symbols.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentTabIndex = 0;
  final List<Widget> _pages = [
    const ExplorePage(),
    const CartPage(),
    const OrdersPage(),
  ];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentTabIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentTabIndex,
      onTap: (index) {
        setState(() {
          _currentTabIndex = index;
          _pageController.jumpToPage(_currentTabIndex);
        });
      },
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Symbols.search_rounded,
            size: 30,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Symbols.shopping_cart_rounded,
            size: 30,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Symbols.package_2_rounded,
            size: 30,
          ),
          label: '',
        ),
      ],
    );
  }
}
