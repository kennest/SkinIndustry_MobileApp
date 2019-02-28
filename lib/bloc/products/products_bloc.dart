import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mobile_ecommerce/api/api.dart';
import 'package:mobile_ecommerce/bloc/products/product_state.dart';
import 'package:mobile_ecommerce/bloc/products/products_event.dart';
import 'package:rxdart/rxdart.dart';

class ProductsBloc extends Bloc<ProductEvent, ProductState> {

@override
  Stream<ProductEvent> transform(Stream<ProductEvent> events) {
    return (events as Observable<ProductEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  ProductState get initialState => ProductUninitialized();

  @override
  Stream<ProductState> mapEventToState(
      ProductState currentState, ProductEvent event) async* {
    if (event is Fetch) {
      try {
        yield ProductUninitialized();
        final categories = await Api().fetchCategories();
        final products = await Api().fetchProducts(categoryId:event.categoryId);
        yield ProductLoaded(categories: categories, products: products);
      } catch (_) {
        yield ProductError();
      }
    }
  }
}
