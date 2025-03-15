import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/app/layout/layout.dart';
import 'package:shop_app/common/theme/colors.dart';
import 'package:shop_app/features/auth/controller/cubit.dart';
import 'package:shop_app/features/auth/view/login_screen.dart';

class IgnitionShop extends StatefulWidget {
  const IgnitionShop({super.key});

  @override
  State<IgnitionShop> createState() => _IgnitionShopState();
}

class _IgnitionShopState extends State<IgnitionShop> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
