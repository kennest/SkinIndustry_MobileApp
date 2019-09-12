import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_ecommerce/bloc/cart/cart_bloc.dart';
import 'package:mobile_ecommerce/floordb/models/product.dart';
import 'package:mobile_ecommerce/pages/widgets/colors.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {

  CartPage({Key key}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //final ScrollController _scrollController = ScrollController();
  double spinner = 0;
  CartBloc cartBloc;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartBloc=CartBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Consumer<CartBloc>(
          builder: (context, cartbloc, _) {
            switch (cartbloc.status) {
              case CartStatus.initial:
                return Container(
                  child: Text('Cart'),
                );
              case CartStatus.added:
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartBloc.cart.hBox.values
                            .toList()
                            .length,
                        itemBuilder: (BuildContext ctx, int index) {
                          Map<int, Product> map =
                          cartBloc.cart.hBox.values.elementAt(index);
                          return Card(
                            elevation: 8.0,
                            margin: new EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.pink[200]),
                              child: cartItem(map.values.first, cartBloc),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              case CartStatus.removed:
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartBloc.cart.hBox.values
                            .toList()
                            .length,
                        itemBuilder: (BuildContext ctx, int index) {
                          Map<int, Product> map =
                          cartBloc.cart.hBox.values.elementAt(index);
                          return Card(
                            elevation: 8.0,
                            margin: new EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            child: Container(
                              decoration:
                              BoxDecoration(color: Colors.pink[200]),
                              child:
                              cartItem(map.values.first, cartBloc),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );

              case CartStatus.loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return Text("Holla");
            }
          }
      ),
      bottomNavigationBar:Consumer<CartBloc>(
          builder: (context, bloc, child){
            return Text("Hello ${bloc.cart.hBox.values.length}");
          })
    );
  }

  Widget bottomBar(CartBloc cartBloc){
   return Row(
      children: <Widget>[
              (cartBloc.status==CartStatus.added)?
                //Compute the price of the products
                 Wrap(
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
                            "${cartBloc.cart.hBox.values.length} FCFA",
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
                ):Text("Empty")

      ],
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
        actionsWidgets(),
        IconButton(
          color: Colors.pinkAccent,
          icon: Icon(Icons.menu, size: 30.0),
          onPressed: () {},
        )
      ],
    );
  }

  Widget actionsWidgets(){
  return Consumer<CartBloc>(
      builder: (context, bloc, child){
        return Row(
          children: <Widget>[

            Stack(
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
                                      CartPage()));
                        },
                      ),
                      (bloc.cart.hBox.values.length >= 0)
                          ? Positioned(
                        left: 25.0,
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(62.0),
                              color: Colors.pink[500]),
                          child: Center(
                            child: Text('${bloc.cart.hBox.values.length}'),
                          ),
                        ),
                      )
                          : null,
                    ],
                  )
          ],
        );
      });
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
        trailing:Consumer<CartBloc>(
            builder: (context, bloc, child){
              return IconButton(
                splashColor: Colors.pinkAccent[600],
                color: Colors.pinkAccent[700],
                icon: Icon(Icons.close, color: Colors.white, size: 30.0),
                onPressed: () {
                  print('removed from cart');
                  bloc.addProduct(n,1);
                },
              );
            }));

    return widget;
  }
}
