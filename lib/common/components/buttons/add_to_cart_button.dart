import 'package:flutter/material.dart';
import 'package:shop_app/common/theme/colors.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //? Add to cart
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
