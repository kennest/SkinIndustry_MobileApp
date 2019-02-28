import 'package:equatable/equatable.dart';
import 'package:mobile_ecommerce/models/category.dart';
import 'package:mobile_ecommerce/models/product.dart';

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
  final List<Product> products;
final List<Category> categories;
  ProductLoaded({this.categories, 
    this.products,
  }) : super([products]);

  ProductLoaded copyWith({
    List<Product> products,
    List<Category> categories
  }) {
    return ProductLoaded(products: products ?? this.products,categories:categories??this.categories );
  }

  @override
  String toString() => 'ProductLoaded { posts: ${products.length} }';
}
