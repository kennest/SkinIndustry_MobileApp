import 'package:equatable/equatable.dart';
import 'package:mobile_ecommerce/models/cart.dart';
import 'package:mobile_ecommerce/models/product.dart';

abstract class CartState extends Equatable {
  CartState([List props = const []]) : super(props);
}

class CartUninitialized extends CartState {
  @override
  String toString() => 'ProductUninitialized';
}

class ProductAdded extends CartState{
    Cart cart;
   
  ProductAdded({this.cart}):super([cart]);
  @override
  String toString() => 'Product added { cart: ${cart.box.length}';
}

class ProductRemoved extends CartState{
    Cart cart;
   
  ProductRemoved({this.cart}):super([cart]);
  @override
  String toString() => 'Product removed { cart: ${cart.box.length} }';
}

class CartEmpty extends CartState {
  @override
  String toString() => 'ProductUninitialized';
}

