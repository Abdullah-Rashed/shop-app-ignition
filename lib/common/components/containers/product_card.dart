import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shop_app/app/app_cubit/cubit.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/common/components/buttons/add_to_cart_button.dart';
import 'package:shop_app/common/components/containers/cached_image.dart';
import 'package:shop_app/common/services/router/app_router.dart';
import 'package:shop_app/features/home/models/product_model.dart';
import 'package:shop_app/features/home/view/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  final ProductsModel? product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final appCubit = serviceLocator<AppCubit>();
    return BlocBuilder(
      bloc: appCubit,
      builder: (context, state) {
        return GestureDetector(
          onTap: () => AppRouter.push(
            screen: ProductDetailsScreen(product: product),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedImage(
                        img: "${product?.images?.first}",
                        width: 180,
                        height: 180,
                      ),
                    ),
                    Positioned.directional(
                      textDirection: TextDirection.ltr,
                      top: 6,
                      end: 6,
                      child: GestureDetector(
                        onTap: () => appCubit.isInWishList(product: product)
                            ? appCubit.removeFromWishList(itemToRemove: product)
                            : appCubit.addToWishList(item: product),
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: appCubit.isInWishList(product: product)
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.favorite_outline,
                                  color: Colors.black,
                                ),
                        ),
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
                              "${product?.title}",
                              maxLines: 2,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$${product?.price}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AddToCartButton(product: product),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
