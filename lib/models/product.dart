import 'package:equatable/equatable.dart';

class Product extends Equatable {
  int id;
  String title;
  String description;
  int price;
  String picture;
  int categoryId;

  Product(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.picture,
      this.categoryId});

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
        id: json['id'],
        description: json['description'],
        title: json['title'],
        price: json['price'],
        picture: json['picture'],
        categoryId: json['category_id']);
  }
}
