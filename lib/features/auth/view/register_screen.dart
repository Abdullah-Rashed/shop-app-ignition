import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/common/components/fields/my_form_field.dart';
import 'package:shop_app/common/services/router/app_router.dart';
import 'package:shop_app/common/services/router/image_picker/image_picker_service.dart';
import 'package:shop_app/common/theme/colors.dart';
import 'package:shop_app/common/utils/validators.dart';
import 'package:shop_app/features/auth/controller/cubit.dart';
import 'package:shop_app/features/auth/controller/states.dart';
import 'package:shop_app/features/auth/view/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final authCubit = serviceLocator<AuthCubit>();
  final imagePickerService = serviceLocator<ImagePickerService>();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome!",
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Gap(20),
            BlocBuilder<AuthCubit, AuthStates>(
              builder: (context, state) => Column(
                children: [
                  Form(
                    key: authCubit.registerFormKey,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: authCubit.imageFile != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(70),
                                      child: Image.file(
                                        authCubit.imageFile!,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ),
                            GestureDetector(
                              onTap: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.photo),
                                        title: Text("Gallery"),
                                        onTap: () {
                                          authCubit.pickImage(
                                              source: "gallery");
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.camera_alt),
                                        title: Text("Camera"),
                                        onTap: () {
                                          authCubit.pickImage(source: "camera");
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              child: CircleAvatar(child: Icon(Icons.add)),
                            ),
                          ],
                        ),
                        MyFormField(
                          controller: authCubit.registerNameController,
                          label: "Name",
                          prefixIcon: Icon(Icons.person_2),
                          validator: (value) =>
                              Validators.validateRequiredField(
                            value: authCubit.registerNameController.text,
                          ),
                        ),
                        Gap(20),
                        MyFormField(
                          controller: authCubit.registerEmailController,
                          label: "Email",
                          prefixIcon: Icon(Icons.mail),
                          validator: (value) => Validators.validateEmail(
                            email: authCubit.registerEmailController.text,
                          ),
                        ),
                        Gap(20),
                        MyFormField(
                          controller: authCubit.registerPwdController,
                          label: "Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: Icon(Icons.visibility),
                          validator: (value) => Validators.validatePassword(
                            pwd: authCubit.registerPwdController.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(20),
            Column(
              children: [
                SizedBox(
                  width: 320,
                  height: 70,
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.primaryColor),
                    ),
                    onPressed: () {
                      if (authCubit.registerFormKey.currentState?.validate() ==
                          true) {
                        //? register function;
                      }
                    },
                    child: Text("Register"),
                  ),
                ),
                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    GestureDetector(
                      onTap: () => AppRouter.pushReplace(screen: LoginScreen()),
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // Text("or"),
                // SizedBox(
                //   height: 10,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       height: 60,
                //       width: 60,
                //       alignment: Alignment.center,
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         color: Colors.grey.shade200,
                //       ),
                //       child: Text("P"),
                //     ),
                //     SizedBox(
                //       width: 16,
                //     ),
                //     Container(
                //       height: 60,
                //       width: 60,
                //       alignment: Alignment.center,
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         color: Colors.grey.shade200,
                //       ),
                //       child: Text("S"),
                //     ),
                //     SizedBox(
                //       width: 16,
                //     ),
                //     Container(
                //       height: 60,
                //       width: 60,
                //       alignment: Alignment.center,
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         color: Colors.grey.shade200,
                //       ),
                //       child: Text("Q"),
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
    ;
  }
}
