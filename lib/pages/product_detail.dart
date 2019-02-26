import 'package:flutter/material.dart';
import 'pages.dart';

class ProductDetailPage extends StatefulWidget {
  final String imgPath;

  ProductDetailPage({Key key, this.imgPath}) : super(key: key);

  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Hero(
              tag: widget.imgPath,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 250.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.imgPath),
                            fit: BoxFit.cover)),
                  ),
                  ListTile(
                    title: Text('Other title',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25.0)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Subtitle',style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15.0)),
                        Text(
                          '300 Eur',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18.0),
                        )
                      ],
                    ),
                  )
                ],
              )),
          ),
        ],
      ),
    );
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
}
