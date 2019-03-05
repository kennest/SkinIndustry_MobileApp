import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_ecommerce/bloc/cart/cart_event.dart';
import 'package:mobile_ecommerce/bloc/cart/cart_state.dart';
import 'package:mobile_ecommerce/models/cart.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  Cart cart;

  CartBloc({@required cart});

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
      yield CartUninitialized();
      print('cartBloc: AddToCart');
      cart.addToCart(event.product, cart.box.length + 1);
      print('cart Size: ${cart.cart.values.length}');
      yield ProductAdded(product: event.product);
    } else if (event is RemoveFromCart) {
      print('cartBloc: RemoveFromCart');
      cart.removeFromCart(event.product, 1);
      yield ProductRemoved(product: event.product);
    }
  }
}
