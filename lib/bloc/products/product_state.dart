import 'package:equatable/equatable.dart';
import 'package:mobile_ecommerce/floordb/models/category.dart';
import 'package:mobile_ecommerce/floordb/models/product.dart';

abstract class ProductState extends Equatable {
  ProductState([List props = const []]) : super(props);
}

class ProductUninitialized extends ProductState {
  @override
  String toString() => 'ProductUninitialized';
}

class ProductError extends ProductState {
  @override
  String toString() => 'ProductError';
}

class ProductLoaded extends ProductState {
  List<Product> products;
  List<Category> categories;
  ProductLoaded({
    this.categories,
    this.products,
  }) : super([products,categories]);

  @override
  String toString() => 'ProductLoaded { posts: ${products.length} }';
}


