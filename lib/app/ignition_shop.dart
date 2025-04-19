import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app/app_cubit/cubit.dart';
import 'package:shop_app/app/app_cubit/states.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/common/theme/colors.dart';
import 'package:shop_app/common/theme/theme.dart';
import 'package:shop_app/features/auth/controller/cubit.dart';
import 'package:shop_app/features/auth/view/login_screen.dart';
import 'package:shop_app/features/auth/view/register_screen.dart';
import 'package:shop_app/features/home/view/home_screen.dart';

class IgnitionShop extends StatefulWidget {
  const IgnitionShop({super.key});

  @override
  State<IgnitionShop> createState() => _IgnitionShopState();
}

class _IgnitionShopState extends State<IgnitionShop> {
  final appCubit = serviceLocator<AppCubit>();
  @override
  void initState() {
    super.initState();
    appCubit.setThemeMode();
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
            home: appCubit.isLoggedIn ? HomeScreen() : LoginScreen(),
          );
        },
      ),
    );
  }
}
