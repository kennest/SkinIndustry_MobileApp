import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:mobile_ecommerce/api/api.dart';
import 'package:mobile_ecommerce/floordb/models/category.dart';
import 'package:mobile_ecommerce/floordb/models/product.dart';

enum ProductStatus { initial, loading, loaded,error }

class ProductBloc extends ChangeNotifier {
  List<Category> _categories = [];
  List<Product> _products = [];
  ProductStatus _status = ProductStatus.initial;

  List<Category> get categories => _categories;

  List<Product> get products => _products;

  ProductStatus get productStatus => _status;

  Future<void> getData(int catId) async {
    _status = ProductStatus.loading;
    try {
      _categories = await Api().fetchCategories();
      _products = await Api().fetchProducts(categoryId: catId);
      _status = ProductStatus.loaded;
      notifyListeners();
    } catch (_) {
      _status = ProductStatus.initial;
      notifyListeners();
    }
  }
}
