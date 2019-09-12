import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:mobile_ecommerce/api/api.dart';
import 'package:mobile_ecommerce/api/graphcool_api.dart';
import 'package:mobile_ecommerce/bloc/products/product_bloc.dart';
import 'package:mobile_ecommerce/floordb/models/cart.dart';
import 'package:mobile_ecommerce/floordb/models/category.dart';
import 'package:mobile_ecommerce/floordb/models/product.dart';
import 'package:mobile_ecommerce/repository/user_controller.dart';

enum CartStatus { initial, loading, added, removed,error }
enum ProductStatus { initial, loading, loaded,error }

class CartBloc extends ChangeNotifier {
  Cart _cart = Cart();
  Product _product;
  ProductBloc _productBloc=ProductBloc();
  UserController _userRepository = UserController();
  CartStatus _status = CartStatus.initial;

  List<Category> _categories = [];
  List<Product> _products = [];
  ProductStatus _productStatus = ProductStatus.initial;

  //GETTERS
  Cart get cart => _cart;
  UserController get userRepository => _userRepository;
  CartStatus get status => _status;
  ProductBloc get productBloc => _productBloc;
  List<Category> get categories => _categories;

  List<Product> get products => _products;

  ProductStatus get productStatus => _productStatus;
  // ignore: unnecessary_getters_setters
  get product => _product;

  Future<void> addProduct(Product p,int qte) async {
      _product=p;
      _cart.addToCart(product, qte);
      _status=CartStatus.added;
      notifyListeners();
  }

  Future<void> removeProduct(Product p,int qte) async {
    _product=p;
    _cart.removeFromCart(product, qte);
    _status=CartStatus.removed;
    notifyListeners();
  }

  Future<void> getData(int catId) async {

    GraphCoolApi().addCategory("Test category");
    GraphCoolApi().getAllCategories();

    _productStatus = ProductStatus.loading;
    _status = CartStatus.loading;
    try {
      _categories = await Api().fetchCategories();
      _products = await Api().fetchProducts(categoryId: catId);
      _productStatus = ProductStatus.loaded;
      _status = CartStatus.initial;
      notifyListeners();
    } catch (_) {
      _productStatus = ProductStatus.initial;
      _status = CartStatus.initial;
      notifyListeners();
    }
  }
}
