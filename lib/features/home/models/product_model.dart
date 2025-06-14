// To parse this JSON data, do
//
//     final productsModel = productsModelFromMap(jsonString);

import 'dart:convert';

List<ProductsModel> productsModelFromMap(String str) =>
    List<ProductsModel>.from(
        json.decode(str).map((x) => ProductsModel.fromMap(x)));

class ProductsModel {
  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  Category? category;
  List<String>? images;
  DateTime? creationAt;
  DateTime? updatedAt;

  ProductsModel({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
    this.creationAt,
    this.updatedAt,
  });

  factory ProductsModel.fromMap(Map<String, dynamic> json) => ProductsModel(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        price: json["price"],
        description: json["description"],
        category: json["category"] == null
            ? null
            : Category.fromMap(json["category"]),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        creationAt: json["creationAt"] == null
            ? null
            : DateTime.parse(json["creationAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  static Map<String, dynamic> toMap({required ProductsModel product}) => {
        "id": product.id,
        "title": product.title,
        "slug": product.slug,
        "price": product.price,
        "description": product.description,
        "category": product.category?.toMap(),
        "images": product.images == null
            ? []
            : List<dynamic>.from(product.images!.map((x) => x)),
        "creationAt": product.creationAt?.toIso8601String(),
        "updatedAt": product.updatedAt?.toIso8601String(),
      };
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? image;
  DateTime? creationAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.creationAt,
    this.updatedAt,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        creationAt: json["creationAt"] == null
            ? null
            : DateTime.parse(json["creationAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "creationAt": creationAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
