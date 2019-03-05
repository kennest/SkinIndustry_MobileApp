import 'package:equatable/equatable.dart';
import 'package:mobile_ecommerce/models/product.dart';

abstract class CartState extends Equatable {
  CartState([List props = const []]) : super(props);
}

class CartUninitialized extends CartState {
  @override
  String toString() => 'ProductUninitialized';
}

class ProductAdded extends CartState{
    Product product;
   
  ProductAdded({this.product}):super([product]);
  @override
  String toString() => 'Product added { cart: ${product.id} }';
}

class ProductRemoved extends CartState{
    Product product;
   
  ProductRemoved({this.product}):super([product]);
  @override
  String toString() => 'Product removed { cart: ${product.id} }';
}

class CartEmpty extends CartState {
  @override
  String toString() => 'ProductUninitialized';
}

