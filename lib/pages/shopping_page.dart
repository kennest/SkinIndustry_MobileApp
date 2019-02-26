import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ecommerce/pages/pages.dart';

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
      '{"last": [{"product_id":"62","thumb":"https://www.soriabel.be/files/17667/products/8810505/skincare_50g.jpg","name":"Test Tilte","price":"\$55.00"}, '
      '{"product_id":"61","thumb":"https://www.revolutionbeauty.com/Images/Models/150/6692.jpg","name":"Test Tilte","price":"\$55.00"}, '
      '{"product_id":"57","thumb":"https://www.revolutionbeauty.com/Images/Models/Full/6687.jpg","name":"Test Tilte","price":"\$55.00"}, '
      '{"product_id":"63","thumb":"https://www.revolutionbeauty.com/Images/Models/Full/6699.jpg","name":"Test Tilte","price":"\$55.00"}, '
      '{"product_id":"64","thumb":"https://www.maquibeauty.fr/images/productos/revolution-skincare-aceite-de-semilla-de-rosa-mosqueta-gold-elixir-2-39713.jpeg","name":"Test Tilte","price":"\$55.00"}, '
      '{"product_id":"58","thumb":"https://www.revolutionbeauty.com/Images/Models/Full/6693.Jpg","name":"Test Tilte","price":"\$55.00"}]}';

  String categoriesJson = '{"categories":['
      '{"name":"Pommades","image":"icon.png","id":2}, '
      '{"name":"Huiles","image":"icon.png","id":4}, '
      '{"name":"Maquillages","image":"icon.png","id":4}, '
      '{"name":"Vernies","image":"icon.png","id":4}, '
      '{"name":"Savons","image":"icon.png","id":6}]}';

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
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      body: CustomScrollView(
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
                                fontSize: 25.0, fontWeight: FontWeight.w600),
                            isScrollable: true,
                            unselectedLabelColor:
                                Color.fromARGB(200, 200, 200, 200),
                            unselectedLabelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600),
                            indicatorColor: Colors.pink,
                            controller: tabController,
                            tabs: getTabs(number: categories.length)),
                      ),
                      Material(
                        color: backgroundColor,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${products.length} products',
                                style: TextStyle(fontWeight: FontWeight.w500),
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
                Map<String, String> product =
                    products[index].cast<String, String>();
                return cardItem(product['thumb']);
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
      tabviews.add(null);
    }
    return tabviews;
  }

  List<Widget> getTabs({int number}) {
    List<Widget> tabs = [];
    for (var i = 0; i < number; i++) {
      Map<String, String> category = categories[i].cast<String, String>();
      tabs.add(Tab(
        child:
            Text('${category['name']}', style: TextStyle(color: Colors.black)),
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

  Widget cardItem(String imgPath) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Hero(
                      tag: imgPath,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 130.0,
                            width: 250.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(imgPath),
                                    fit: BoxFit.cover)),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => ProductDetailPage(
                                            imgPath: imgPath,
                                          )));
                            },
                            title: Text('Other title'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Subtitle'),
                                Text(
                                  '300 Eur',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.0),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
          Positioned(
              top: 180.0,
              left: 120.0,
              child: SizedBox(
                width: 50.0,
                child: RaisedButton(
                  highlightColor: Colors.pink,
                  splashColor: Colors.pink[100],
                  color: Colors.pink,
                  child: Icon(
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
