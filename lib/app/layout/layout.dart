import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shop_app/common/theme/colors.dart';
import 'package:shop_app/features/account/view/account_screen.dart';
import 'package:shop_app/features/home/view/home_screen.dart';
import 'package:shop_app/features/shop/view/shop_screen.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final controller = PersistentTabController();
  List<Widget> screens = [
    HomeScreen(),
    ShopScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        controller: controller,
        tabs: [
          PersistentTabConfig(
            screen: HomeScreen(),
            item: ItemConfig(
              icon: Icon(Icons.home),
              inactiveIcon: Icon(Icons.home_outlined),
              activeForegroundColor: Color(0XFFFF660E),
              inactiveForegroundColor: Color(0XFF0F0E0E),
              title: "Home",
            ),
          ),
          PersistentTabConfig(
            screen: ShopScreen(),
            item: ItemConfig(
              icon: Icon(Icons.shop),
              inactiveIcon: Icon(Icons.shop_outlined),
              activeForegroundColor: MyLightColors.primaryColor,
              inactiveForegroundColor: Color(0XFF0F0E0E),
              title: "Shop",
            ),
          ),
          PersistentTabConfig(
            screen: ShopScreen(),
            item: ItemConfig(
              icon: Icon(Icons.person_3),
              inactiveIcon: Icon(Icons.person_3_outlined),
              activeForegroundColor: MyLightColors.primaryColor,
              inactiveForegroundColor: Color(0XFF0F0E0E),
              title: "Account",
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(),
        ),
      ),
    );
  }
}
