import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        'https://png.pngtree.com/thumb_back/fw800/back_pic/04/02/33/4558041fe55aaf0.jpg',
                      ),
                      fit: BoxFit.cover)),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 80.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "Perfect Skin Industry",
                              style: TextStyle(fontSize: 30.0),
                            ),
                            subtitle: Text('Service de soins de peaux',
                                style: TextStyle(fontSize: 15.0)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: RaisedButton(
                      elevation: 8.0,
                      color: Colors.pink,
                      onPressed: () {
                        Navigator.push(context, CupertinoPageRoute(
                          builder: (context)=>LoginPage()
                        ));
                      },
                      child: Text(
                        'Start shopping',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
