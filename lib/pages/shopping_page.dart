import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_ecommerce/bloc/cart/cart_bloc.dart';
import 'package:mobile_ecommerce/bloc/cart/cart_event.dart';
import 'package:mobile_ecommerce/bloc/cart/cart_state.dart';
import 'package:mobile_ecommerce/bloc/products/product_state.dart';
import 'package:mobile_ecommerce/bloc/products/products_bloc.dart';
import 'package:mobile_ecommerce/bloc/products/products_event.dart';
import 'package:mobile_ecommerce/models/cart.dart';
import 'package:mobile_ecommerce/models/category.dart';
import 'package:mobile_ecommerce/models/product.dart';
import 'package:mobile_ecommerce/pages/pages.dart';
import 'package:scoped_model/scoped_model.dart';

class ShoppingPage extends StatefulWidget {
  ShoppingPage({Key key}) : super(key: key);

  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage>
    with TickerProviderStateMixin {
  TabController tabController;
  final ScrollController _scrollController = ScrollController();
  ProductsBloc productBloc = ProductsBloc();
  Map<int, Product> cart = Map();
  CartBloc cartBloc = CartBloc(cart: Cart());
  int selectedtab = 0;

  @override
  void initState() {
    super.initState();
    productBloc.dispatch(Fetch(categoryId: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      body: BlocBuilder(
          bloc: productBloc,
          builder: (BuildContext context, ProductState state) {
            if (state is ProductUninitialized) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductLoaded) {
              tabController = TabController(
                  length: state.categories.length,
                  vsync: this,
                  initialIndex: selectedtab);
              if (state.products.length == 0) {
                return Center(
                  child: IconButton(
                    highlightColor: Colors.pink[100],
                    splashColor: Colors.pink[200],
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.pink[400],
                    ),
                    onPressed: () {
                      productBloc.dispatch(Fetch(categoryId: 1));
                    },
                  ),
                );
              }
              return CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverToBoxAdapter(
                      child: Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Material(
                                color: backgroundColor,
                                child: TabBar(
                                    indicatorSize: TabBarIndicatorSize.label,
                                    labelStyle: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w600),
                                    isScrollable: true,
                                    unselectedLabelColor:
                                        Color.fromARGB(200, 200, 200, 200),
                                    unselectedLabelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600),
                                    indicatorColor: Colors.pink,
                                    controller: tabController,
                                    tabs: getTabs(state.categories)),
                              ),
                              Material(
                                color: backgroundColor,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      15.0, 20.0, 15.0, 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '${state.products.length} products',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      new DropdownButton<String>(
                                        value: 'Popular',
                                        items: <String>['Popular', 'Recents']
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (_) {},
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ))),
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return cardItem(context, state.products[index], state);
                      },
                      childCount: state.products.length,
                    ),
                  ),
                ],
              );
            } else if (state is ProductError) {
              return Center(
                child: Text('Error Api'),
              );
            }
          }),
    );
  }

  List<Widget> getTabView({int number}) {
    List<Widget> tabviews = [];
    for (var i = 0; i < number; i++) {
      tabviews.add(null);
    }
    return tabviews;
  }

  List<Widget> getTabs(List<Category> categories) {
    List<Widget> tabs = [];
    for (var c in categories) {
      tabs.add(Tab(
        child: FlatButton(
          child: Text('${c.name}', style: TextStyle(color: Colors.black)),
          onPressed: () {
            print('${tabController.index} /${c.id}');
            selectedtab = (c.id - 1);
            tabController.animateTo(c.id - 1);
            productBloc.dispatch(Fetch(categoryId: c.id));
          },
        ),
      ));
    }
    return tabs;
  }

  Widget getAppBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.pinkAccent, //change your color here
      ),
      backgroundColor: backgroundColor,
      elevation: 0.0,
      actions: <Widget>[
        ScopedModel<Cart>(
          model: cartBloc.cart,
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
                                  CartPage(cartBloc: cartBloc)));
                    },
                  ),
                  (model.cart.values.length >= 0)
                      ? Positioned(
                          left: 25.0,
                          child: Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(62.0),
                                color: Colors.pink[500]),
                            child: Center(
                              child: Text('${model.cart.values.length}'),
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

  Widget cardItem(BuildContext ctx, Product p, ProductState productstate) {
    print('Cart Rebuild ${p.id}');
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Wrap(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Hero(
                          tag: p.picture,
                          child: Column(
                            children: <Widget>[
                              CachedNetworkImage(
                                height: 130.0,
                                width: 250.0,
                                imageUrl: p.picture,
                                placeholder: (ctx, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (ctx, url, error) =>
                                    Icon(Icons.error),
                              ),
                              Material(
                                color: Colors.white,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (ctx) => ProductDetailPage(
                                                  product: p,
                                                )));
                                  },
                                  title: Text(p.title),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(p.description),
                                      Text(
                                        '${p.price}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.0),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
          BlocBuilder(
            bloc: cartBloc,
            builder: (ctx, CartState cardstate) {
              if (cardstate is CartUninitialized) {
                return Positioned(
                    top: 180.0,
                    left: 120.0,
                    child: Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink,
                      ),
                      child: IconButton(
                        highlightColor: Colors.pink,
                        splashColor: Colors.pink[100],
                        color: Colors.pink,
                        icon: Icon(
                          Icons.add_shopping_cart,
                          size: 20.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          cartBloc.dispatch(new AddToCart(
                              product: p, qte: cartBloc.cart.box.length + 1));
                        },
                      ),
                    ));
              } else if (cardstate is ProductAdded) {
                return Positioned(
                    top: 180.0,
                    left: 120.0,
                    child: Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink,
                      ),
                      child: ScopedModel<Cart>(
                        model: cartBloc.cart,
                        child: ScopedModelDescendant<Cart>(
                          rebuildOnChange: true,
                          builder: (context, child, model) {
                            if (model.box.containsValue(p)) {
                              print('${p.id} contained in Cart');
                              model.box.forEach((k, v) {
                                print('$k / ${v.title} ${v.id}');
                              });
                            }
                            return IconButton(
                              highlightColor: Colors.pink,
                              splashColor: Colors.pink[100],
                              color: (model.box.containsValue(p))
                                  ? Colors.pink
                                  : Colors.grey,
                              icon: Icon(
                                Icons.add_shopping_cart,
                                size: 20.0,
                                color: Colors.white,
                              ),
                              onPressed: (model.box.containsValue(p))
                                  ?() {
                                      print('cartBtn pressed');
                                      cartBloc.dispatch(
                                          AddToCart(product: p, qte: 2));
                                    }:() {},
                            );
                          },
                        ),
                      ),
                    ));
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    productBloc.dispose();
    cartBloc.dispose();
    super.dispose();
  }
}
