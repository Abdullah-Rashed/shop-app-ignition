// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromMap(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromMap(String str) =>
    UserInfoModel.fromMap(json.decode(str));

String userInfoModelToMap(UserInfoModel data) => json.encode(data.toMap());

class UserInfoModel {
  int? id;
  String? email;
  String? password;
  String? name;
  String? role;
  String? avatar;

  UserInfoModel({
    this.id,
    this.email,
    this.password,
    this.name,
    this.role,
    this.avatar,
  });

  factory UserInfoModel.fromMap(Map<String, dynamic> json) => UserInfoModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        role: json["role"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "password": password,
        "name": name,
        "role": role,
        "avatar": avatar,
      };
}
