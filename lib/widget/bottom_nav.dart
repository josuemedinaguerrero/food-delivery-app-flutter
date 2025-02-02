import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_getx/pages/home_page.dart';
import 'package:food_delivery_getx/pages/order_page.dart';
import 'package:food_delivery_getx/pages/profile_page.dart';
import 'package:food_delivery_getx/pages/wallet_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late HomePage homePage;
  late ProfilePage profilePage;
  late OrderPage orderPage;
  late WalletPage walletPage;

  @override
  void initState() {
    homePage = HomePage();
    orderPage = OrderPage();
    profilePage = ProfilePage();
    walletPage = WalletPage();
    pages = [homePage, orderPage, walletPage, profilePage];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentTabIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.transparent,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 500),
        items: [
          Icon(Icons.home_outlined, size: 30, color: Colors.white),
          Icon(Icons.shopping_bag_outlined, color: Colors.white),
          Icon(Icons.wallet_outlined, color: Colors.white),
          Icon(Icons.person_outline, color: Colors.white),
        ],
        onTap: (value) {
          setState(() {
            currentTabIndex = value;
          });
        },
      ),
    );
  }
}
