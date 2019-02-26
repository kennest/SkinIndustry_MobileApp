import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_ecommerce/pages/ui/category_grid.dart';

class ShoppingPage extends StatefulWidget {
  ShoppingPage({Key key}) : super(key: key);

  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage>
    with SingleTickerProviderStateMixin {
  var tabController;
  var number_category = 3;
  final ScrollController _scrollController = ScrollController();

  List<dynamic> products;
  List<dynamic> categories;

 String productsJson =
    '{"last": [{"product_id":"62","thumb":"sandwich.png","name":"Test Tilte","price":"\$55.00"}, '
    '{"product_id":"61","thumb":"sandwich.png","name":"Test Tilte","price":"\$55.00"}, '
    '{"product_id":"57","thumb":"sandwich.png","name":"Test Tilte","price":"\$55.00"}, '
    '{"product_id":"63","thumb":"sandwich.png","name":"Test Tilte","price":"\$55.00"}, '
    '{"product_id":"64","thumb":"sandwich.png","name":"Test Tilte","price":"\$55.00"}, '
    '{"product_id":"58","thumb":"sandwich.png","name":"Test Tilte","price":"\$55.00"}, '
    '{"product_id":"59","thumb":"sandwich.png","name":"Test Tilte","price":"\$55.00"}]}';

String categoriesJson = '{"categories":['
    '{"name":"Category 1","image":"icon.png","id":2}, '
    '{"name":"Category 2","image":"icon.png","id":4}, '
    '{"name":"Category 3","image":"icon.png","id":4}, '
    '{"name":"Category 4","image":"icon.png","id":4}, '
    '{"name":"Category 5","image":"icon.png","id":6}]}';

  @override
  void initState() {
    super.initState();
        Map<String, dynamic> decoded = json.decode(productsJson);
    products = decoded['last'];

    Map<String, dynamic> decodedCategories = json.decode(categoriesJson);
    categories = decodedCategories['categories'];
        tabController =
        TabController(length: categories.length, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: Colors.transparent,
      body:CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child:  TabBar(
                isScrollable: true,
                indicatorColor: Colors.pink,
                controller: tabController,
                tabs: getTabs(number: categories.length)
              ),
            )
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                Map<String, String> product =
                    products[index].cast<String, String>();
                return Card(
                  child: Container(
                    color: Colors.grey[400],
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.0),
                      child: Center(
                          child: Text("Product ${product["product_id"]}")),
                    ),
                  ),
                );
              },
              childCount: products.length,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getTabView({int number}) {
    List<Widget> tabviews = [];
    for (var i = 0; i < number; i++) {
      tabviews.add(new CategoryGrid(
        category: "Sofa",
      ));
    }
    return tabviews;
  }

  List<Widget> getTabs({int number}) {
   
    List<Widget> tabs = [];
    for (var i = 0; i < number; i++) {
       Map<String, String> category =
                      categories[i].cast<String, String>();
      tabs.add(Tab(
        child: Text('${category['name']}', style: TextStyle(color: Colors.black)),
      ));
    }
    return tabs;
  }

  Widget getAppBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.pinkAccent, //change your color here
      ),
      backgroundColor: Colors.white,
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
}
