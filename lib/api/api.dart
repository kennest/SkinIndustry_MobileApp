import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_ecommerce/models/category.dart';
import 'package:mobile_ecommerce/models/product.dart';
import 'package:path_provider/path_provider.dart';


class Api {
  var url = "https://my-json-server.typicode.com/kennest/json-db/";

  List<Category> categories = [];
  List<Product> products = [];

  Future<List<Product>> fetchProducts({int categoryId = 1}) async {
    downloadFile(url: '${url}products');
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

  void downloadFile({String url}) async {

Uri uir=Uri.parse(url);
    print("URL:" + url);
    HttpClient client = new HttpClient();
    var _downloadData = StringBuffer();
    var file ;
    //Define the file path
    getExternalStorageDirectory().then((dir){
      file= new File(dir.path+'/http_downloaded.json');
    });

    client.getUrl(Uri.parse(url)).then((request) {
      return request.close();
    }).then((response) {
      response.transform(utf8.decoder).listen((data) {
        _downloadData.write(data);
        print("JSON:"+data);
      }).onDone(() {
        file.writeAsString(_downloadData.toString());
      });
    });
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
