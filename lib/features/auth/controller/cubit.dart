import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/common/services/router/image_picker/image_picker_service.dart';
import 'package:shop_app/features/auth/controller/states.dart';

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
  void pickImage({required String source}) async {
    if (source == "camera") {
      pickedImage = await imagePickerService.pickImageFromCamera();
    } else {
      pickedImage = await imagePickerService.pickImageFromGallery();
    }
    imageFile = File("${pickedImage?.path}");
    Logger().d(pickedImage?.name);
    Logger().d(pickedImage?.path);

    emit(PickedImageState());
  }
}
