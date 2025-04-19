import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_app/common/components/buttons/add_to_cart_button.dart';

class ProductCard extends StatelessWidget {
  final String img;
  final String name;
  final String price;
  const ProductCard({
    super.key,
    required this.img,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Container(
                alignment: Alignment.center,
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade100,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    image: AssetImage(img),
                  ),
                ),
              ),
              Positioned.directional(
                textDirection: TextDirection.ltr,
                top: 6,
                end: 6,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.favorite_outline),
                ),
              ),
            ],
          ),
          Gap(12),
          SizedBox(
            width: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        price,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                AddToCartButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
