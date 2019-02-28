import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {}

class Fetch extends ProductEvent {
  @override
  String toString() => 'Fetch';
}