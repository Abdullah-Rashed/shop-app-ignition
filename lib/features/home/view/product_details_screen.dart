import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shop_app/app/app_cubit/cubit.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/common/components/containers/cached_image.dart';
import 'package:shop_app/common/components/containers/icon_tray.dart';
import 'package:shop_app/features/home/controllers/cubit.dart';
import 'package:shop_app/features/home/models/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductsModel? product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final homeCubit = serviceLocator<HomeCubit>();
  final appCubit = serviceLocator<AppCubit>();
  int selectedImgIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconTray(
            child: Icon(Icons.share_outlined),
          ),
          Gap(15),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                CachedImage(
                  img: "${widget.product?.images?[selectedImgIndex]}",
                  width: double.infinity,
                  height: 400,
                ),
                BlocBuilder(
                  bloc: appCubit,
                  builder: (context, state) => Positioned.directional(
                    textDirection: TextDirection.ltr,
                    top: 10,
                    end: 10,
                    child: GestureDetector(
                      onTap: () =>
                          appCubit.isInWishList(product: widget.product)
                              ? appCubit.removeFromWishList(
                                  itemToRemove: widget.product)
                              : appCubit.addToWishList(item: widget.product),
                      child: appCubit.isInWishList(product: widget.product)
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
                Positioned.directional(
                  textDirection: TextDirection.ltr,
                  bottom: 20,
                  end: 0,
                  start: 0,
                  height: 74,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    height: 74,
                    child: ListView.separated(
                      itemCount: widget.product?.images?.length ?? 0,
                      padding: EdgeInsets.symmetric(vertical: 6),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => Gap(6),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImgIndex = index;
                            });
                          },
                          child: CachedImage(
                            img: "${widget.product?.images?[index]}",
                            width: 74,
                            height: 74,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.product?.title}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextTheme.of(context).titleMedium,
                    ),
                    Text(
                      "${widget.product?.category?.name}",
                      overflow: TextOverflow.ellipsis,
                      style: TextTheme.of(context).labelLarge?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                  ],
                ),
              ),
              Text(
                "\$${widget.product?.price}",
                style: TextTheme.of(context).titleLarge,
              ),
            ],
          ),
          Gap(20),
          Text(
            "Description",
            style: TextTheme.of(context).titleLarge,
          ),
          Text(
            "${widget.product?.description}",
            style: TextTheme.of(context).bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          Gap(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilledButton(
                onPressed: () {
                  serviceLocator<AppCubit>().addToCart(item: widget.product);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primaryContainer,
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag_outlined),
                    Gap(8),
                    Text("Add To Cart")
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(7),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Row(
                      children: [
                        Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.remove),
                        ),
                        Gap(20),
                        Text(
                          "1",
                          style: TextTheme.of(context).labelLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Gap(20),
                        Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
