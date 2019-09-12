import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ecommerce/bloc/cart/cart_bloc.dart';
import 'package:mobile_ecommerce/floordb/models/category.dart';
import 'package:mobile_ecommerce/floordb/models/product.dart';
import 'package:mobile_ecommerce/pages/pages.dart';
import 'package:provider/provider.dart';

class ShoppingPage extends StatefulWidget {
  ShoppingPage({Key key}) : super(key: key);

  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> with TickerProviderStateMixin {
  TabController tabController;
  final ScrollController _scrollController = ScrollController();
  Map<int, Product> cart = Map();
  CartBloc cartBloc = CartBloc();
  int selectedtab = 0;

  @override
  void initState() {
    super.initState();
    cartBloc.getData(10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      body:Consumer<CartBloc>(
          builder: (context, bloc, child){
            return shoppingBody(bloc);
          }),
    );
  }

  Widget shoppingBody(CartBloc bloc){
          if (bloc.status==CartStatus.initial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (bloc.status ==CartStatus.added) {
            var n=Category(10,"Kits Perfect Skin",'icon.png');
            tabController = TabController(
                length: bloc.cart.hBox.values.length,
                vsync: this,
                initialIndex: selectedtab);
            if (bloc.cart.hBox.length == 0) {
              return Center(
                child: IconButton(
                  highlightColor: Colors.pink[100],
                  splashColor: Colors.pink[200],
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.pink[400],
                  ),
                  onPressed: () {
                    cartBloc.getData(1);
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
                                  tabs: getTabs(bloc.categories)),
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
                                      '${cartBloc.productBloc.products.length} products',
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
                      return Container(
                        child: cardItem(context, cartBloc.productBloc.products[index], cartBloc),
                      );
                    },
                    childCount: cartBloc.productBloc.products.length,
                  ),
                ),
              ],
            );
          } else if (bloc.status == CartStatus.loading) {
            return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      highlightColor: Colors.pink[100],
                      splashColor: Colors.pink[200],
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.pink[400],
                      ),
                      onPressed: () {
                        bloc.getData(1);
                      },
                    ),
                    Text("Reesayer",style: TextStyle(color: Colors.pink[400]),)
                  ],
                )

            );
          }

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
            cartBloc.productBloc.getData(c.id);
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
    Consumer<CartBloc>(
    builder: (context, bloc, child){
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
              );
            },
          ),
        IconButton(
          color: Colors.pinkAccent,
          icon: Icon(Icons.menu, size: 30.0),
          onPressed: () {},
        )
      ],
    );
  }

  Widget cardItem(BuildContext ctx, Product p, CartBloc bloc) {
    print('Cart Rebuild ${p.id}');
    return Card(
      margin: EdgeInsets.all(1.0),
      color: Colors.white,
      child: Stack(
        fit: StackFit.passthrough,
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
                                  title:  Text(p.description),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '${p.price} FCFA',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.0),
                                      ),
                                      OutlineButton(
                                        padding: EdgeInsets.fromLTRB(45.0, 0.0, 45.0, 0.0),
                                        child: Text("Acheter",textAlign: TextAlign.center,),
                                        onPressed: (){},
                                      ),

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
              // ignore: missing_return
              (bloc.status== CartStatus.initial) ?
                 Positioned(
                    top: 0.0,
                    left: 120.0,
                    child: Container(
                      width: 50.0,
                      height: 50.0,
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
                              cartBloc.addProduct( p, 1);
                            },
                          ),

                    )):

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
                      child:Text(""),
    ))

        ],
      ),
    );
  }

  @override
  void dispose() {
    cartBloc.dispose();
    super.dispose();
  }
}
