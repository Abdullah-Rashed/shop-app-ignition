import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shop_app/app/app_cubit/cubit.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/common/components/fields/my_form_field.dart';
import 'package:shop_app/common/services/router/app_router.dart';
import 'package:shop_app/common/theme/colors.dart';
import 'package:shop_app/common/utils/validators.dart';
import 'package:shop_app/features/auth/controller/cubit.dart';
import 'package:shop_app/features/auth/controller/states.dart';
import 'package:shop_app/features/auth/view/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = serviceLocator<AuthCubit>();
    final appCubit = serviceLocator<AppCubit>();
    return BlocConsumer(
      bloc: authCubit,
      listener: (context, state) {
        if (state is LoginErrorState) {
          appCubit.showErrorDialog(errorMsg: state.msg);
        }
      },
      builder: (context, state) {
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
                      "Hello!",
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Sign in to your account",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Form(
                      key: authCubit.loginFormKey,
                      child: Column(
                        children: [
                          MyFormField(
                            controller: authCubit.loginEmailController,
                            label: "Email",
                            prefixIcon: Icon(Icons.mail),
                            validator: (value) => Validators.validateEmail(
                              email: authCubit.loginEmailController.text,
                            ),
                          ),
                          Gap(20),
                          MyFormField(
                            controller: authCubit.loginPwdController,
                            label: "Password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Icon(Icons.visibility),
                            validator: (value) => Validators.validatePassword(
                              pwd: authCubit.loginPwdController.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(20),
                Column(
                  children: [
                    SizedBox(
                      width: 320,
                      height: 70,
                      child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              MyLightColors.primaryColor),
                        ),
                        onPressed: () {
                          if (authCubit.loginFormKey.currentState?.validate() ==
                              true) {
                            authCubit.login();
                          }
                        },
                        child: Text("Log in"),
                      ),
                    ),
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        GestureDetector(
                          onTap: () =>
                              AppRouter.pushReplace(screen: RegisterScreen()),
                          child: Text(
                            "Create",
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
      },
    );
  }
}
