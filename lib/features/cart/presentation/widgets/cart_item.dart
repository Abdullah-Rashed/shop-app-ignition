import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:shop_app/app/app_cubit/cubit.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/common/components/containers/cached_image.dart';
import 'package:shop_app/features/home/models/product_model.dart';

class CartItem extends StatefulWidget {
  final ProductsModel product;
  const CartItem({super.key, required this.product});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final appCuit = serviceLocator<AppCubit>();
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.product.id),
      enabled: true,
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => appCuit.removeFromCart(
              itemToRemove: widget.product,
            ),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.clear,
            label: 'Delete',
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedImage(
                  img: "${widget.product.images?.first}",
                  height: 60,
                  width: 60,
                ),
              ),
              Gap(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.product.title}",
                    style: TextTheme.of(context).titleSmall,
                  ),
                  Text(
                    "${widget.product.category?.name}",
                    style: TextTheme.of(context).labelMedium?.copyWith(
                          color: Colors.grey.shade400,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "\$${widget.product.price}",
            style: TextTheme.of(context).titleLarge,
          )
        ],
      ),
    );
  }
}
