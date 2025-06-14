import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shop_app/app/app_cubit/cubit.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/common/components/containers/cached_image.dart';
import 'package:shop_app/features/cart/presentation/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final appCubit = serviceLocator<AppCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: appCubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Cart"),
          ),
          body: appCubit.cart.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 60,
                        color: Colors.grey,
                      ),
                      Gap(12),
                      Text(
                        "Cart is Empty!",
                        style: TextTheme.of(context).titleLarge?.copyWith(
                              color: Colors.grey,
                            ),
                      )
                    ],
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  itemCount: appCubit.cart.length,
                  separatorBuilder: (context, index) => Gap(16),
                  itemBuilder: (context, index) {
                    return CartItem(product: appCubit.cart[index]);
                  },
                ),
        );
      },
    );
  }
}
