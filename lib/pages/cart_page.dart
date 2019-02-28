import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_ecommerce/bloc/cart/cart_state.dart';

class CartPage extends StatefulWidget {
  final cartBloc;
  CartPage({Key key, this.cartBloc}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          BlocBuilder(
              bloc: widget.cartBloc,
              builder: (BuildContext context, CartState state) {
                if (state is ProductAdded) {
                  return Center(
                    child: Text('${state.cart.cartProducts.length}'),
                  );
                }
              })
        ],
      ),
    );
  }
}
