import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shop_app/app/app_cubit/cubit.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/common/dialogs/loading_dialog.dart';
import 'package:shop_app/common/models/error_model.dart';
import 'package:shop_app/common/network/client.dart';
import 'package:shop_app/common/network/endpoints.dart';
import 'package:shop_app/common/services/image_picker/image_picker_service.dart';
import 'package:shop_app/common/services/router/app_router.dart';
import 'package:shop_app/common/services/shared_prefs/shared_prefs.dart';
import 'package:shop_app/features/auth/controller/states.dart';
import 'package:shop_app/features/auth/models/login_model.dart';
import 'package:shop_app/features/auth/models/resgister_model.dart';
import 'package:shop_app/features/auth/view/login_screen.dart';
import 'package:shop_app/features/home/view/home_screen.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(InitialState());

  final loginFormKey = GlobalKey<FormState>();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPwdController = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();
  TextEditingController registerNameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPwdController = TextEditingController();

  final imagePickerService = serviceLocator<ImagePickerService>();
  XFile? pickedImage;
  File? imageFile;
  bool isPicked = false;
  void pickImage({required String source}) async {
    if (source == "camera") {
      pickedImage = await imagePickerService.pickImageFromCamera();
    } else {
      pickedImage = await imagePickerService.pickImageFromGallery();
    }
    imageFile = File("${pickedImage?.path}");
    emit(PickedImageState());
  }

  final dioClient = serviceLocator<DioClient>();
  final appCubit = serviceLocator<AppCubit>();

  void register({
    required String name,
    required String email,
    required String pwd,
    String? avatar,
  }) {
    emit(RegisterLoadingState());
    appCubit.showLoadingDialog();
    dioClient.post(
      EndPoints.register,
      data: {
        "name": name,
        "email": email,
        "password": pwd,
        "avatar":
            "https://happyuser.com.pl/wp-content/uploads/2023/09/Mask-Group-8.png",
      },
    ).then((response) {
      appCubit.hideDialog();
      if (response.statusCode == 201) {
        // RegistterModel registterModel = RegistterModel.fromMap(response.data);
        //TODO move the saving of user data into login() and hit the retrieve user profile API
        // SharedPrefs.setString("userImage", "${registterModel.avatar}");
        // SharedPrefs.setString("username", "${registterModel.name}");
        AppRouter.pushReplace(screen: LoginScreen());
        emit(RegisterSuccessState());
      } else {
        ErrorModel errorModel = ErrorModel.fromMap(response.data);
        emit(RegisterErrorState(
          code: errorModel.statusCode!,
          msg: errorModel.message!.first,
        ));
        appCubit.showErrorDialog(
          errorMsg: errorModel.message?.first ?? "Something went wrong",
        );
      }
    });
    //? Loading state

    //? Success state

    //? Error state
  }

  void login() {
    emit(LoginLoadingState());
    appCubit.showLoadingDialog();
    dioClient.post(
      EndPoints.login,
      data: {
        "email": loginEmailController.text.trim(),
        "password": loginPwdController.text.trim(),
      },
    ).then((response) {
      appCubit.hideDialog();
      if (response.statusCode == 201) {
        LoginModel loginModel = LoginModel.fromMap(response.data);
        SharedPrefs.setString("accessToken", "${loginModel.accessToken}");
        AppRouter.pushReplace(screen: HomeScreen());
        emit(LoginSuccessState());
      } else {
        if (response.statusCode == 401) {
          emit(LoginErrorState(
            code: 401,
            msg: "Email or password is incorrect.",
          ));
        } else {
          emit(LoginErrorState(
            code: 9000,
            msg: "Something went wrong",
          ));
        }
      }
    });
    //? Loading state

    //? Success state

    //? Error state
  }
}
