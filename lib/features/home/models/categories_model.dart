// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromMap(jsonString);

import 'dart:convert';

List<CategoriesModel> categoriesModelFromMap(String str) =>
    List<CategoriesModel>.from(
        json.decode(str).map((x) => CategoriesModel.fromMap(x)));

String categoriesModelToMap(List<CategoriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class CategoriesModel {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? creationAt;
  String? updatedAt;

  CategoriesModel({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.creationAt,
    this.updatedAt,
  });

  factory CategoriesModel.fromMap(Map<String, dynamic> json) => CategoriesModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        creationAt: json["creationAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "creationAt": creationAt,
        "updatedAt": updatedAt,
      };
}
