import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app/app_cubit/cubit.dart';
import 'package:shop_app/app/app_cubit/states.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/app/layout/layout.dart';
import 'package:shop_app/common/constants/constants.dart';
import 'package:shop_app/common/services/notifications/notifications.dart';
import 'package:shop_app/common/services/shared_prefs/shared_prefs.dart';
import 'package:shop_app/common/theme/colors.dart';
import 'package:shop_app/common/theme/theme.dart';
import 'package:shop_app/features/auth/controller/cubit.dart';
import 'package:shop_app/features/auth/view/login_screen.dart';
import 'package:shop_app/features/auth/view/register_screen.dart';
import 'package:shop_app/features/home/controllers/cubit.dart';
import 'package:shop_app/features/home/view/home_screen.dart';

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  logger.w('Title: ${message.notification?.title}');
  logger.w('Body: ${message.notification?.body}');
  logger.w('Payload: ${message.data}');
  FirebaseNotifications.display(message);
}

class IgnitionShop extends StatefulWidget {
  const IgnitionShop({super.key});

  @override
  State<IgnitionShop> createState() => _IgnitionShopState();
}

class _IgnitionShopState extends State<IgnitionShop> {
  final appCubit = serviceLocator<AppCubit>();
  @override
  void initState() {
    if (SharedPrefs.getBool(Constants.biometricsEnabledKey)) {
      serviceLocator<AppCubit>().authenticateBiometrics().then((authenticated) {
        if (authenticated == true) {
          initMethods();
        } else {
          SystemNavigator.pop();
        }
      });
    } else {
      initMethods();
    }

    super.initState();
  }

  void initMethods() {
    super.initState();
    appCubit.setThemeMode();
    appCubit.setCart();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        bloc: appCubit,
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navKey,
            debugShowCheckedModeBanner: false,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            themeMode: appCubit.themeMode,
            home: appCubit.isLoggedIn ? Layout() : LoginScreen(),
          );
        },
      ),
    );
  }
}
