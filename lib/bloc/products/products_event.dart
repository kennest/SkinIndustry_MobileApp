import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile_ecommerce/models/product.dart';

abstract class ProductEvent extends Equatable {
  ProductEvent([List props = const []]) : super(props);
}

class Fetch extends ProductEvent {
  int categoryId;

  Fetch({@required this.categoryId}):super([categoryId]);
  @override
  String toString() => 'Fetch : $categoryId';
}

