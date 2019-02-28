import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_ecommerce/bloc/products/product_state.dart';
import 'package:mobile_ecommerce/bloc/products/products_bloc.dart';
import 'package:mobile_ecommerce/bloc/products/products_event.dart';
import 'package:mobile_ecommerce/models/category.dart';
import 'package:mobile_ecommerce/models/product.dart';
import 'package:mobile_ecommerce/pages/pages.dart';

class ShoppingPage extends StatefulWidget {
  ShoppingPage({Key key}) : super(key: key);

  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage>
    with TickerProviderStateMixin {
  var tabController;
  final ScrollController _scrollController = ScrollController();
  ProductsBloc productBloc = ProductsBloc();

  @override
  void initState() {
    super.initState();
    productBloc.dispatch(Fetch());
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
                  initialIndex: 1);
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
                        Product product = state.products[index];
                        return cardItem(product);
                      },
                      childCount: state.products.length,
                    ),
                  ),
                ],
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
        child: Text('${c.name}', style: TextStyle(color: Colors.black)),
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
        IconButton(
          color: Colors.pinkAccent,
          icon: Icon(Icons.shopping_cart),
          onPressed: () {},
        ),
        IconButton(
          color: Colors.pinkAccent,
          icon: Icon(Icons.menu),
          onPressed: () {},
        )
      ],
    );
  }

  Widget cardItem(Product product) {
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
                          tag: product.picture,
                          child: Column(
                            children: <Widget>[
                              CachedNetworkImage(
                                height: 130.0,
                                width: 250.0,
                                imageUrl: product.picture,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              Material(
                                color: Colors.white,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                ProductDetailPage(
                                                  product: product,
                                                )));
                                  },
                                  title: Text(product.title),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(product.description),
                                      Text(
                                        '${product.price}',
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
          Positioned(
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
                  onPressed: () {},
                ),
              ))
        ],
      ),
    );
  }
}
