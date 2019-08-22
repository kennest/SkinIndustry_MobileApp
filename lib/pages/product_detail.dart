import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ecommerce/floordb/models/product.dart';
import 'package:numberpicker/numberpicker.dart';
import 'pages.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  ProductDetailPage({Key key, this.product}) : super(key: key);

  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  double spinner = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: getAppBar(),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 130.0,
            width: MediaQuery.of(context).size.width,
            child: Hero(
                tag: widget.product.picture,
                child: Column(
                  children: <Widget>[
                   CachedNetworkImage(
                     fit: BoxFit.cover,
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            imageUrl: widget.product.picture,
                            placeholder: (context, url) =>
                                 CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                 Icon(Icons.error),
                          ),
                    Material(
                      color: backgroundColor,
                      child: ListTile(
                        title: Text(widget.product.title,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 25.0)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.product.description,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0)),
                            Text(
                              '${widget.product.price} Eur',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18.0),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          Container(
              color: backgroundColor,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                margin: EdgeInsets.all(20),
                child: NumberPicker.integer(
                initialValue: 50,
                minValue: 0,
                maxValue: 100,
                onChanged: _handleChange),
              ),
                    Container(
                      width: 350.0,
                      height: 50.0,
                      padding: EdgeInsets.only(bottom: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                      child: FlatButton(
                        onPressed: () {},
                        color: Colors.pink,
                        splashColor: Colors.pink[100],
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  _handleChange(num){

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
