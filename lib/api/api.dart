import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_ecommerce/models/category.dart';
import 'package:mobile_ecommerce/models/product.dart';

class Api {
  var url = "https://my-json-server.typicode.com/kennest/json-db/";
  List<Product> products = [];
  List<Category> categories = [];

  Future<List<Product>> fetchProducts({int categoryId = 1}) async {
    final response = await http.get('${url}products');
    if (response.statusCode == 200) {
      print(response.body);
      var jsonData = json.decode(response.body) as List;

      jsonData.forEach((n) {
        print("**************");
        print(n);
        print("**************");
        Product p = Product.fromJson(n);
        products.add(p);
      });

      products = products.where((p) => (p.categoryId == categoryId)).toList();
      print("******Products filtered********");
      print(products.length);
      print("******Products filtered********");
    }
    return products;
  }

  Future<List<Category>> fetchCategories() async {
    final response = await http.get('${url}categories');
    if (response.statusCode == 200) {
      print(response.body);
      var jsonData = json.decode(response.body) as List;

      jsonData.forEach((n) {
        print("**************");
        print(n);
        print(jsonData.length);
        print("**************");
        Category c = Category.fromJson(n);
        categories.add(c);
      });
    }
    return categories;
  }
}
