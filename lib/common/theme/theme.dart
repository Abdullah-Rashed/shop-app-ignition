import 'package:flutter/material.dart';
import 'package:shop_app/common/theme/colors.dart';
import 'package:shop_app/common/theme/text_theme.dart';

class MyThemes {
  static ThemeData lightTheme = ThemeData(
    textTheme: MyTextTheme.lightTextTheme,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: MyLightColors.primaryColor,
      primaryContainer: MyLightColors.primaryColor,
      onPrimaryContainer: MyLightColors.onPrimaryContainer,
      secondaryContainer: MyLightColors.secondaryContainer,
      onSecondaryContainer: MyLightColors.onSecondaryContainer,

      // secondary: ,
      // onSecondary: ,
      // tertiary: ,
      // onTertiary: ,
      // tertiaryContainer: ,
      // onTertiaryContainer: ,

      // surface: ,
      // onSurface: ,

      // outline: ,
      // outlineVariant: ,
    ),
    iconTheme: IconThemeData(
      color: MyLightColors.iconColor,
    ),
    scaffoldBackgroundColor: MyLightColors.scaffoldBgColor,
    appBarTheme: AppBarTheme(
      backgroundColor: MyLightColors.appBarBgColor,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    listTileTheme: ListTileThemeData(
      iconColor: MyDarkColors.onSecondaryContainer,
      tileColor: MyDarkColors.secondaryContainer,
      textColor: MyDarkColors.onSecondaryContainer,
    ),
    textTheme: MyTextTheme.darkTextTheme,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: MyDarkColors.primaryColor,
      primaryContainer: MyDarkColors.primaryColor,
      onPrimaryContainer: MyDarkColors.onPrimaryContainer,
      secondaryContainer: MyDarkColors.secondaryContainer,
      onSecondaryContainer: MyDarkColors.onSecondaryContainer,
    ),
    iconTheme: IconThemeData(
      color: MyDarkColors.iconColor,
    ),
    scaffoldBackgroundColor: MyDarkColors.scaffoldBgColor,
    appBarTheme: AppBarTheme(
      backgroundColor: MyDarkColors.appBarBgColor,
      foregroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );
}
