import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile_ecommerce/floordb/models/product.dart';

abstract class CartEvent extends Equatable{
   CartEvent([List props = const []]) : super(props);
}

class AddToCart extends CartEvent {
  Product product;
  int qte;

  AddToCart({@required this.product,@required this.qte}):super([product,qte]);
  @override
  String toString() => 'Added to Cart : $product.id';
}

class RemoveFromCart extends CartEvent {
  Product product;

  RemoveFromCart({@required this.product}):super([product]);
  @override
  String toString() => 'Added to Cart : $product.id';
}