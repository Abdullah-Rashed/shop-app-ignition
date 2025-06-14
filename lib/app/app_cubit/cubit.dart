import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app/app_cubit/states.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/common/constants/constants.dart';
import 'package:shop_app/common/dialogs/error_dialog.dart';
import 'package:shop_app/common/dialogs/loading_dialog.dart';
import 'package:shop_app/common/services/local_auth/local_auth.dart';
import 'package:shop_app/common/services/router/app_router.dart';
import 'package:shop_app/common/services/shared_prefs/shared_prefs.dart';
import 'package:shop_app/features/home/models/product_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  List<ProductsModel> cart = List.empty(growable: true);
  List<ProductsModel> wishList = List.empty(growable: true);
  void modifyCartCount() {
    cartCount = jsonDecode(SharedPrefs.getString(Constants.cartKey)).length;
    emit(CartIcremented());
  }

  int cartCount = 0;

  void setCart() {
    final userStoredCart = SharedPrefs.getString(Constants.cartKey);

    if (userStoredCart.isNotEmpty) {
      logger.w("NOT EMPTY");
      try {
        final List storedCartList = jsonDecode(userStoredCart);
        storedCartList
            .map((element) => cart.add(ProductsModel.fromMap(element)))
            .toList();
        cartCount = cart.length;
      } catch (e) {
        logger.e('Error parsing cart: $e');
      }
    }
  }

  void addToCart({required item}) async {
    try {
      cart.add(item);
      List tempList =
          cart.map((item) => ProductsModel.toMap(product: item)).toList();
      await SharedPrefs.setString(Constants.cartKey, jsonEncode(tempList));
      modifyCartCount();
      emit(ItemAddedToCart());
    } catch (e) {
      logger.e(e);
    }
  }

  void removeFromCart({required ProductsModel itemToRemove}) async {
    cart.removeWhere((cartItem) => cartItem.id == itemToRemove.id);
    List tempList =
        cart.map((item) => ProductsModel.toMap(product: item)).toList();
    await SharedPrefs.setString(Constants.cartKey, jsonEncode(tempList));
    modifyCartCount();
    emit(ItemRemovedFromCartCart());
  }

  void setWishList() {
    final userStoredWishList = SharedPrefs.getString(Constants.wishListKey);

    if (userStoredWishList.isNotEmpty) {
      logger.w("NOT EMPTY");
      try {
        final List storedWishListList = jsonDecode(userStoredWishList);
        storedWishListList
            .map((element) => wishList.add(ProductsModel.fromMap(element)))
            .toList();
      } catch (e) {
        logger.e('Error parsing wishList: $e');
      }
    }
  }

  void addToWishList({required ProductsModel? item}) async {
    try {
      wishList.add(item!);
      List tempList =
          wishList.map((item) => ProductsModel.toMap(product: item)).toList();
      await SharedPrefs.setString(Constants.wishListKey, jsonEncode(tempList));
      isInWishList(product: item);
      emit(ItemAddedToWishList());
      logger.w(tempList);
    } catch (e) {
      logger.e(e);
    }
  }

  void removeFromWishList({required ProductsModel? itemToRemove}) async {
    wishList.removeWhere((wishListItem) => wishListItem.id == itemToRemove?.id);
    List tempList =
        wishList.map((item) => ProductsModel.toMap(product: item)).toList();
    await SharedPrefs.setString(Constants.wishListKey, jsonEncode(tempList));
    isInWishList(product: itemToRemove);
    emit(ItemRemovedFromWishList());
  }

  bool isInWishList({required ProductsModel? product}) {
    bool isInWishList = false;
    wishList.map((wishListItem) {
      if (wishListItem.id == product?.id) {
        isInWishList = true;
      }
    }).toList();
    return isInWishList;
  }

  final authService = serviceLocator<LocalAuthService>();
  Future<bool> authenticateBiometrics() async {
    bool authenticated = false;
    final availableBiometrics = await authService.getAvailableBiometrics();
    if (availableBiometrics.isEmpty) {
      authenticated = await authService.authenticateWithDevicePassword();
    } else {
      authenticated = await authService.authenticateWithBiometrics();
    }

    return authenticated;
  }

  ThemeMode? themeMode;
  void setThemeMode() {
    if (SharedPrefs.getString(Constants.themeModeKey) == ThemeEnums.dark.name) {
      themeMode = ThemeMode.dark;
    } else if (SharedPrefs.getString(Constants.themeModeKey) ==
        ThemeEnums.light.name) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.system;
    }
  }

  Future<void> setLightMode() async {
    themeMode = ThemeMode.light;
    await SharedPrefs.setString(Constants.themeModeKey, ThemeEnums.light.name);
    reRender();
    emit(SwitchToLightState());
  }

  void setDarkMode() {
    themeMode = ThemeMode.dark;
    SharedPrefs.setString(Constants.themeModeKey, ThemeEnums.dark.name);
    reRender();
    emit(SwitchToDarkState());
  }

  void setFollowSystem() {
    themeMode = ThemeMode.system;
    SharedPrefs.setString(Constants.themeModeKey, ThemeEnums.system.name);
    reRender();
    emit(SwitchToFollowSystemState());
  }

  void reRender() {
    emit(ReRenderState());
  }

  void showLoadingDialog() {
    showDialog(
      context: navKey.currentState!.context,
      barrierDismissible: false,
      builder: (context) => LoadingDialog(),
    );
  }

  void hideDialog() {
    AppRouter.pop();
  }

  void showErrorDialog({required String errorMsg}) {
    showDialog(
      context: navKey.currentState!.context,
      builder: (context) => ErrorDialog(
        errorMsg: errorMsg,
      ),
    );
  }

  bool get isLoggedIn => SharedPrefs.getString("accessToken").isNotEmpty;

  bool get isDarkMode =>
      Theme.of(navKey.currentState!.context).brightness == Brightness.dark;
}
