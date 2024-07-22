import 'package:json_annotation/json_annotation.dart';

import 'category.dart';

@JsonSerializable()
class Product {
  int id;
  String title;
  num price;
  String description;
  Category category;
  List<String> images;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.images});

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      description: map['description'],
      category: Category.fromMap(map['category']),
      images: List<String>.from(map['images']),
    );
  }


}
