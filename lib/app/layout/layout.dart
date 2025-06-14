import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shop_app/app/app_cubit/cubit.dart';
import 'package:shop_app/app/get_it/get_it.dart';
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
    WishListScreen(),
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
              activeForegroundColor: MyLightColors.primaryColor,
              inactiveForegroundColor: serviceLocator<AppCubit>().isDarkMode
                  ? Colors.white
                  : Colors.black,
              title: "Home",
            ),
          ),
          // PersistentTabConfig(
          //   screen: ShopScreen(),
          //   item: ItemConfig(
          //     icon: Icon(Icons.shop),
          //     inactiveIcon: Icon(Icons.shop_outlined),
          //     activeForegroundColor: MyLightColors.primaryColor,
          //     inactiveForegroundColor: serviceLocator<AppCubit>().isDarkMode
          //         ? Colors.white
          //         : Colors.black,
          //     title: "Shopping",
          //   ),
          // ),
          PersistentTabConfig(
            screen: WishListScreen(),
            item: ItemConfig(
              icon: Icon(Icons.favorite),
              inactiveIcon: Icon(Icons.favorite_outline),
              activeForegroundColor: MyLightColors.primaryColor,
              inactiveForegroundColor: serviceLocator<AppCubit>().isDarkMode
                  ? Colors.white
                  : Colors.black,
              title: "Wishlist",
            ),
          ),
          PersistentTabConfig(
            screen: WishListScreen(),
            item: ItemConfig(
              icon: Icon(Icons.person_3),
              inactiveIcon: Icon(Icons.person_3_outlined),
              activeForegroundColor: MyLightColors.primaryColor,
              inactiveForegroundColor: serviceLocator<AppCubit>().isDarkMode
                  ? Colors.white
                  : Colors.black,
              title: "Account",
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Padding(
          padding: EdgeInsets.only(bottom: 6),
          child: Style1BottomNavBar(
            navBarConfig: navBarConfig,
            navBarDecoration: NavBarDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
