import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                      image: AssetImage(
                        'images/background.jpg',
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
                                leading: Image.asset('images/new-log.png',height: 150.0,),
                                title: Text(
                                  "Perfect Skin Industry",
                                  style: TextStyle(fontSize: 17.0),
                                ),
                                subtitle: Text('Bienvenue dans la famille',
                                    style: TextStyle(fontSize: 15.0)),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                    child: Align(
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
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            'Rejoindre Perfect Skin Industry',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                      )),
                  )
                  ,
                ],
              ))
        ],
      ),
    );
  }
}
