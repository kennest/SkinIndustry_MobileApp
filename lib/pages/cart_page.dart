import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_ecommerce/bloc/cart/cart_bloc.dart';
import 'package:mobile_ecommerce/bloc/cart/cart_event.dart';
import 'package:mobile_ecommerce/bloc/cart/cart_state.dart';
import 'package:mobile_ecommerce/models/cart.dart';
import 'package:mobile_ecommerce/models/product.dart';
import 'package:mobile_ecommerce/pages/ui/colors.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPage extends StatefulWidget {
  final CartBloc cartBloc;

  CartPage({Key key, this.cartBloc}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //final ScrollController _scrollController = ScrollController();
  double spinner = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: BlocBuilder(
          bloc: widget.cartBloc,
          builder: (BuildContext context, CartState state) {
            if (state is ProductAdded) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cart.Hbox.values.toList().length,
                      itemBuilder: (BuildContext ctx, int index) {
                        Map<int, Product> map =
                            state.cart.Hbox.values.elementAt(index);
                        return Card(
                          elevation: 8.0,
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.pink[200]),
                            child: cartItem(map.values.first, widget.cartBloc),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            } else if (state is CartUninitialized) {
              return Container(
                child: Text('Cart'),
              );
            } else if (state is ProductRemoved) {
              if (state.cart.Hbox.values.length > 0) {
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.cart.Hbox.values.toList().length,
                        itemBuilder: (BuildContext ctx, int index) {
                          Map<int, Product> map =
                              state.cart.Hbox.values.elementAt(index);
                          return Card(
                            elevation: 8.0,
                            margin: new EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            child: Container(
                              decoration:
                                  BoxDecoration(color: Colors.pink[200]),
                              child:
                                  cartItem(map.values.first, widget.cartBloc),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                  child: Icon(Icons.info),
                );
              }
            }
          }),
      bottomNavigationBar: Row(
        children: <Widget>[
          BlocBuilder(
              bloc: widget.cartBloc,
              builder: (BuildContext context, CartState state) {
                if (state is ProductAdded) {
                  //Compute the price of the products
                  var price = 0;
                  state.cart.Hbox.forEach((k, v) {
                    v.forEach((i, p) {
                      price = price + p.price;
                    });
                  });

                  return Wrap(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              color: Colors.pink[100],
                            ),
                            padding: EdgeInsets.all(5.0),
                            margin: EdgeInsets.all(4.0),
                            child: Text(
                              "$price FCFA",
                              style: TextStyle(
                                  fontSize: 25.0, color: Colors.pink[500]),
                            ),
                          ),
                          Container(
                            //padding:EdgeInsets.all(10.0),
                            margin: EdgeInsets.all(5.0),
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: RaisedButton(
                                color: Colors.pink[300],
                                child: Text(
                                  "BUY",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {}),
                          )
                        ],
                      )
                    ],
                  );
                }
              })
        ],
      ),
    );
  }

  Widget getAppBar() {
    return AppBar(
      title: Text('Cart', style: TextStyle(color: Colors.pink)),
      iconTheme: IconThemeData(
        color: Colors.pinkAccent, //change your color here
      ),
      backgroundColor: backgroundColor,
      elevation: 0.0,
      actions: <Widget>[
        ScopedModel<Cart>(
          model: widget.cartBloc.cart,
          child: ScopedModelDescendant<Cart>(
            rebuildOnChange: true,
            builder: (context, child, model) {
              return Stack(
                children: <Widget>[
                  IconButton(
                    color: Colors.pinkAccent,
                    icon: Icon(
                      Icons.shopping_cart,
                      size: 30.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  CartPage(cartBloc: widget.cartBloc)));
                    },
                  ),
                  (model.Hcart.values.length >= 0)
                      ? Positioned(
                          left: 25.0,
                          child: Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(62.0),
                                color: Colors.pink[500]),
                            child: Center(
                              child: Text('${model.Hcart.values.length}'),
                            ),
                          ),
                        )
                      : null,
                ],
              );
            },
          ),
        ),
        IconButton(
          color: Colors.pinkAccent,
          icon: Icon(Icons.menu, size: 30.0),
          onPressed: () {},
        )
      ],
    );
  }

  Widget cartItem(Product n, CartBloc cartBloc) {
    var widget = ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: CachedNetworkImage(
          height: 50.0,
          width: 50.0,
          imageUrl: n.picture,
          placeholder: (ctx, url) => CircularProgressIndicator(),
          errorWidget: (ctx, url, error) => Icon(Icons.error),
        ),
        title: Text(
          "${n.title}",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Icon(Icons.monetization_on, color: Colors.yellowAccent),
            Text(" ${n.price}", style: TextStyle(color: Colors.white)),
          ],
        ),
        trailing: BlocBuilder(
          bloc: cartBloc,
          builder: (BuildContext ctx, CartState state) {
            if (state is CartUninitialized ||
                state is ProductAdded ||
                state is ProductRemoved) {
              return IconButton(
                splashColor: Colors.pinkAccent[600],
                color: Colors.pinkAccent[700],
                icon: Icon(Icons.close, color: Colors.white, size: 30.0),
                onPressed: () {
                  print('removed from cart');
                  cartBloc.dispatch(RemoveFromCart(product: n));
                },
              );
            }
          },
        ));

    return widget;
  }
}
