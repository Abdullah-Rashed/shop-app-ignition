import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/common/network/client.dart';
import 'package:shop_app/common/network/endpoints.dart';
import 'package:shop_app/features/home/controllers/states.dart';
import 'package:shop_app/features/home/models/categories_model.dart';
import 'package:shop_app/features/home/models/product_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  final dioClient = serviceLocator<DioClient>();
  List<CategoriesModel>? categories = List.empty(growable: true);
  bool loadingCategories = true;

  int selectedCategoryId = 0;

  void selectCategory(int categoryId) {
    selectedCategoryId = categoryId;
    emit(CategorySelected());
  }

  void getHomeCategories() {
    emit(HomeCategoriesLoadingState());
    dioClient.get(
      EndPoints.getCategories,
      queryParameters: {
        "limit": 4,
      },
    ).then(
      (response) {
        loadingCategories = false;
        if (response.statusCode == 200) {
          if (response.data.isNotEmpty) {
            response.data.map((item) {
              categories?.add(CategoriesModel.fromMap(item));
            }).toList();
          }
          selectedCategoryId = categories?.first.id ?? 0;
          emit(HomeCategoriesSuccessState());
        }
      },
    ).catchError((error) {
      loadingCategories = false;
      logger.e(error);
      emit(HomeCategoriesErrorState(
        msg: error.toString(),
      ));
    });
  }

  List<ProductsModel>? products = List.empty(growable: true);
  bool isLoadingProducts = true;
  void getHomeProducts() {
    emit(HomeProductsLoadingState());
    dioClient.get(
      EndPoints.getProducts,
      queryParameters: {
        "limit": 10,
        "offset": 0,
      },
    ).then(
      (response) {
        logger.w(response);
        if (response.statusCode == 200) {
          response.data.map((item) {
            products?.add(ProductsModel.fromMap(item));
          }).toList();
        }
        isLoadingProducts = false;
        emit(HomeProductsSuccessState());
      },
    ).catchError((error) {
      isLoadingProducts = false;
      emit(HomeProductsErrorState(
        msg: error.toString(),
      ));
    });
  }
}
