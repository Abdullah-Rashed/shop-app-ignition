import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_app/app/app_cubit/cubit.dart';
import 'package:shop_app/common/network/client.dart';
import 'package:shop_app/common/services/image_picker/image_picker_service.dart';
import 'package:shop_app/features/auth/controller/cubit.dart';
import 'package:logger/logger.dart';

final serviceLocator = GetIt.instance;
final navKey = GlobalKey<NavigatorState>();
final logger = Logger();

Future<void> initDependencies() async {
  serviceLocator.registerFactory(() => ImagePickerService());
  serviceLocator.registerLazySingleton(() => AuthCubit());
  serviceLocator.registerLazySingleton(() => AppCubit());
  serviceLocator.registerSingleton<DioClient>(DioClient());
}
