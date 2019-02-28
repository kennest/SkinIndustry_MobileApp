import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mobile_ecommerce/api/api.dart';
import 'package:mobile_ecommerce/bloc/products/product_state.dart';
import 'package:mobile_ecommerce/bloc/products/products_event.dart';

class ProductsBloc extends Bloc<ProductEvent, ProductState> {
  var api=Api();
  @override
  ProductState get initialState => ProductUninitialized();

  @override
  Stream<ProductState> mapEventToState(ProductState currentState, ProductEvent event) async* {
    if(event is Fetch){
      try{
      final products= await api.fetchProducts(categoryId: 1);
      final categories= await api.fetchCategories();
      yield ProductLoaded(categories:categories,products: products);
      }catch(_){
        yield ProductError();
      }
    }
  }
}