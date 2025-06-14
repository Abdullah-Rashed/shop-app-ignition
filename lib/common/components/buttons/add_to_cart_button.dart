import 'package:flutter/material.dart';
import 'package:shop_app/app/app_cubit/cubit.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/common/theme/colors.dart';
import 'package:shop_app/features/home/models/product_model.dart';

class AddToCartButton extends StatelessWidget {
  final ProductsModel? product;
  const AddToCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        serviceLocator<AppCubit>().addToCart(item: product);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: MyLightColors.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
