import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shop_app/app/app_cubit/cubit.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/common/components/buttons/add_to_cart_button.dart';
import 'package:shop_app/common/components/containers/category_tray.dart';
import 'package:shop_app/common/components/containers/icon_tray.dart';
import 'package:shop_app/common/components/containers/product_card.dart';
import 'package:shop_app/common/components/misc/loading_indicator.dart';
import 'package:shop_app/common/constants/constants.dart';
import 'package:shop_app/common/services/router/app_router.dart';
import 'package:shop_app/common/services/shared_prefs/shared_prefs.dart';
import 'package:shop_app/common/theme/colors.dart';
import 'package:shop_app/features/auth/controller/cubit.dart';
import 'package:shop_app/features/cart/presentation/view/cart_screen.dart';
import 'package:shop_app/features/home/controllers/cubit.dart';
import 'package:shop_app/features/home/controllers/states.dart';
import 'package:shop_app/features/settings/presentation/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final homeCubit = serviceLocator<HomeCubit>();
    homeCubit.getHomeCategories();
    homeCubit.getHomeProducts();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = serviceLocator<HomeCubit>();
    return BlocConsumer<HomeCubit, HomeStates>(
      bloc: homeCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
          ),
          body: ListView(
            children: [
              Gap(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => AppRouter.push(screen: SettingsScreen()),
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(18),
                              color: MyLightColors.primaryColor,
                            ),
                          ),
                        ),
                        Gap(8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello ${serviceLocator<AuthCubit>().userInfoModel?.name ?? ""}",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Text(
                              "Good Morning!",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        IconTray(
                          child: Icon(
                            Icons.notifications_outlined,
                            size: 28,
                          ),
                        ),
                        Gap(12),
                        GestureDetector(
                          onTap: () => AppRouter.push(screen: CartScreen()),
                          child: Stack(
                            children: [
                              IconTray(
                                child: Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 28,
                                ),
                              ),
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.red,
                                child: Text(
                                    "${serviceLocator<AppCubit>().cartCount}"),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onTapOutside: (event) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        decoration: InputDecoration(
                          prefixIconColor: Theme.of(context).iconTheme.color,
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                          hintText: "Search..",
                          hintStyle: TextTheme.of(context).labelLarge?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                          filled: true,
                          fillColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    Gap(12),
                    IconTray(child: Icon(Icons.swap_vert))
                  ],
                ),
              ),
              Gap(24),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            serviceLocator<AppCubit>().modifyCartCount();
                          },
                          child: Text(
                            "See All",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(12),
                  SizedBox(
                    height: 50,
                    child: homeCubit.loadingCategories == true
                        ? LoadingIndicator()
                        : ListView.separated(
                            itemCount: homeCubit.categories?.length ?? 0,
                            padding: EdgeInsetsDirectional.only(
                              start: 16,
                            ),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => Gap(12),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => homeCubit.selectCategory(
                                    homeCubit.categories?[index].id ?? 0),
                                child: CategoryTray(
                                  name: "${homeCubit.categories?[index].name}",
                                  selected: homeCubit.selectedCategoryId ==
                                      homeCubit.categories?[index].id,
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
              Gap(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Products",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Gap(12),
              SizedBox(
                height: 270,
                child: homeCubit.isLoadingProducts == true
                    ? LoadingIndicator()
                    : ListView.separated(
                        itemCount: homeCubit.products?.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => Gap(12),
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: homeCubit.products?[index],
                          );
                        },
                      ),
              ),
              Gap(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 30),
                  decoration: BoxDecoration(
                    color: MyLightColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "40%",
                        style: TextStyle(
                          fontSize: 48,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(10),
                      Flexible(
                        child: Text(
                          "Get your special sale Up to",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Gap(10),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
