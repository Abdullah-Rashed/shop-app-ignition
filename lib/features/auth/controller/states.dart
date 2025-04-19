abstract class AuthStates {}

class InitialState extends AuthStates {}

class PickedImageState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterErrorState extends AuthStates {
  final int code;
  final String msg;
  RegisterErrorState({
    this.code = 9000,
    this.msg = "Something went wrong",
  });
}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {
  final int code;
  final String msg;
  LoginErrorState({
    this.code = 9000,
    this.msg = "Something went wrong",
  });
}
