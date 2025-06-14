import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_app/app/app_cubit/cubit.dart';
import 'package:shop_app/common/network/client.dart';
import 'package:shop_app/common/services/image_picker/image_picker_service.dart';
import 'package:shop_app/common/services/local_auth/local_auth.dart';
import 'package:shop_app/common/services/url_launcher/url_launcher.dart';
import 'package:shop_app/features/auth/controller/cubit.dart';
import 'package:logger/logger.dart';
import 'package:shop_app/features/home/controllers/cubit.dart';

final serviceLocator = GetIt.instance;
final navKey = GlobalKey<NavigatorState>();
final logger = Logger();

Future<void> initDependencies() async {
  serviceLocator.registerFactory(() => ImagePickerService());
  serviceLocator.registerLazySingleton(() => AuthCubit());
  serviceLocator.registerLazySingleton(() => AppCubit());
  serviceLocator.registerLazySingleton(() => HomeCubit());
  serviceLocator.registerSingleton<DioClient>(DioClient());
  serviceLocator.registerFactory(() => LocalAuthService());
  serviceLocator.registerLazySingleton(() => UrlLauncherService());
}
