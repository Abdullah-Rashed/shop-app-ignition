import 'dart:convert';

ErrorModel errorModelFromMap(String str) =>
    ErrorModel.fromMap(json.decode(str));

String errorModelToMap(ErrorModel data) => json.encode(data.toMap());

class ErrorModel {
  List<String>? message;
  String? error;
  int? statusCode;

  ErrorModel({
    this.message,
    this.error,
    this.statusCode,
  });

  factory ErrorModel.fromMap(Map<String, dynamic> json) => ErrorModel(
        message: json["message"] == null
            ? []
            : List<String>.from(json["message"]!.map((x) => x)),
        error: json["error"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toMap() => {
        "message":
            message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
        "error": error,
        "statusCode": statusCode,
      };
}
