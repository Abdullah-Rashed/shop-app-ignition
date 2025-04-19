import 'dart:convert';

LoginModel loginModelFromMap(String str) =>
    LoginModel.fromMap(json.decode(str));

String loginModelToMap(LoginModel data) => json.encode(data.toMap());

class LoginModel {
  String? accessToken;
  String? refreshToken;

  LoginModel({
    this.accessToken,
    this.refreshToken,
  });

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}
