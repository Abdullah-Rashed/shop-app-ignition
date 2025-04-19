import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app/app_cubit/states.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/common/constants/constants.dart';
import 'package:shop_app/common/dialogs/error_dialog.dart';
import 'package:shop_app/common/dialogs/loading_dialog.dart';
import 'package:shop_app/common/services/router/app_router.dart';
import 'package:shop_app/common/services/shared_prefs/shared_prefs.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

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
}
