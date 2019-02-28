import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_ecommerce/models/category.dart';
import 'package:mobile_ecommerce/models/product.dart';

class Api {
  var url = "https://my-json-server.typicode.com/kennest/json-db/";
  List<Product> products = [];
  List<Category> categories = [];

  Future<List<Product>> fetchProducts() async {
    http.get('${url}products').then((data) {
      print(data.body);
      var jsonData = json.decode(data.body) as List;

      jsonData.forEach((n) {
        print("**************");
        print(n);
        print("**************");
         Product p = Product.fromJson(n);
        products.add(p);
      });
 
    });
    return products;
  }

  Future<List<Category>> fetchCategories() async {
    http.get('${url}categories').then((data) {
      print(data.body);
      var jsonData = json.decode(data.body) as List;

      jsonData.forEach((n) {
        print("**************");
        print(n);
        print(jsonData.length);
        print("**************");
        Category c = Category.fromJson(n);
        categories.add(c);
      });
    });
    return categories;
  }
}
