import 'package:flutter/material.dart';
import 'pages.dart';
import 'package:spinner_input/spinner_input.dart';

class ProductDetailPage extends StatefulWidget {
  final String imgPath;

  ProductDetailPage({Key key, this.imgPath}) : super(key: key);

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
                tag: widget.imgPath,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 300.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: NetworkImage(widget.imgPath),
                              fit: BoxFit.cover)),
                    ),
                    Material(
                      color: backgroundColor,
                      child: ListTile(
                        title: Text('Other title',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 25.0)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Subtitle',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0)),
                            Text(
                              '300 Eur',
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
                child: SpinnerInput(
                  minValue: 0,
                  maxValue: 200,
                  step: 1,
                  plusButton: SpinnerButtonStyle(elevation: 0, color: Colors.pink[100], borderRadius: BorderRadius.circular(32.0)),
                  minusButton: SpinnerButtonStyle(elevation: 0, color: Colors.pink.withOpacity(0.5), borderRadius: BorderRadius.circular(32.0)),
                  middleNumberWidth: 70,
                  middleNumberStyle: TextStyle(fontSize: 21),
                  spinnerValue: spinner,
                  onChange: (newValue) {
                    setState(() {
                      spinner = newValue;
                    });
                  },
                ),
              ),
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
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
