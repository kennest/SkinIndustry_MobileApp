import 'package:equatable/equatable.dart';
import 'package:mobile_ecommerce/floordb/models/cart.dart';

abstract class CartState extends Equatable {
  CartState([List props = const []]) : super(props);
}

class CartUninitialized extends CartState {
  @override
  String toString() => 'ProductUninitialized';
}

class ProductAdded extends CartState {
  Cart cart;

  ProductAdded({this.cart}) : super([cart]);
  @override
  String toString() => 'Product added { cart: ${cart.Hbox.length}';
}

class ProductRemoved extends CartState {
  Cart cart;

  ProductRemoved({this.cart}) : super([cart]);
  @override
  String toString() => 'Product removed { cart: ${cart.Hbox.length} }';
}

class CartEmpty extends CartState {
  @override
  String toString() => 'ProductUninitialized';
}
