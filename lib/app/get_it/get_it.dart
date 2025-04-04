import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_app/common/services/image_picker/image_picker_service.dart';
import 'package:shop_app/features/auth/controller/cubit.dart';

final serviceLocator = GetIt.instance;
final navKey = GlobalKey<NavigatorState>();

Future<void> initDependencies() async {
  serviceLocator.registerFactory(() => ImagePickerService());
  serviceLocator.registerLazySingleton(() => AuthCubit());
}
