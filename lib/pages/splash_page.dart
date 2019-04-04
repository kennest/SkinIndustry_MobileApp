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
                        'https://www.pcaskin.com/skin/frontend/mw2consulting/consumers/images/consumers/topmenu/sensitive.jpg',
                      ),
                      fit: BoxFit.cover)),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 80.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                          ),
                          height: 80.0,
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
                        )),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 45.0,
                        child: RaisedButton(
                          elevation: 8.0,
                          color: Colors.pink,
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => UserTypePage()));
                          },
                          child: Text(
                            'Start shopping',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                      )),
                ],
              ))
        ],
      ),
    );
  }
}
