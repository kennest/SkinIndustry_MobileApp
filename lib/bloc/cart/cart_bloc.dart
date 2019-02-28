import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mobile_ecommerce/bloc/cart/cart_event.dart';
import 'package:mobile_ecommerce/bloc/cart/cart_state.dart';
import 'package:mobile_ecommerce/models/cart.dart';
import 'package:mobile_ecommerce/models/product.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final Map<int, Product> products = Map();
  final cart = Cart();

@override
  Stream<CartEvent> transform(Stream<CartEvent> events) {
    return (events as Observable<CartEvent>)
        .debounce(Duration(milliseconds: 200));
  }

  @override
  CartState get initialState => CartUninitialized();

  @override
  Stream<CartState> mapEventToState(
      CartState currentState, CartEvent event) async* {
    if (event is AddToCart) {
      products[event.qte] = event.product;
      cart.cartProducts = products;
      yield ProductAdded(cart: cart);
    } else if (event is RemoveFromCart) {
      products.remove(event.product);
      cart.cartProducts = products;
      yield ProductRemoved(cart: cart);
    }
  }
}
