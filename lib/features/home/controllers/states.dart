abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeCategoriesLoadingState extends HomeStates {}

class HomeCategoriesErrorState extends HomeStates {
  final String? msg;
  final int? code;
  HomeCategoriesErrorState({
    this.msg = "Something went wrong",
    this.code = 9000,
  });
}

class HomeCategoriesSuccessState extends HomeStates {}

class HomeProductsLoadingState extends HomeStates {}

class HomeProductsErrorState extends HomeStates {
  final String? msg;
  final int? code;
  HomeProductsErrorState({
    this.msg = "Something went wrong",
    this.code = 9000,
  });
}

class HomeProductsSuccessState extends HomeStates {}

class CategorySelected extends HomeStates {}
