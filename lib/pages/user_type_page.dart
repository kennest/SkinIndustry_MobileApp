import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages.dart';

class UserTypePage extends StatefulWidget {
  UserTypePage({Key key}) : super(key: key);

  _UserTypePageState createState() => _UserTypePageState();
}

class _UserTypePageState extends State<UserTypePage> {
  String client = "client";
  String vendeur = "vendeur";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text("Choisir le type de Compte:"),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
              height: 250.0,
              child: Column(
                children: <Widget>[
                  IconButton(
                    splashColor: Colors.indigo.withOpacity(0.5),
                    color: Colors.indigoAccent,
                    iconSize: 160.0,
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => LoginPage(
                                    type: client,
                                  )));
                    },
                    icon: Icon(Icons.account_box),
                  ),
                  Text("Client", style: TextStyle(fontSize: 25.0))
                ],
              )),
          Container(
            height: 250.0,
            child: Column(
              children: <Widget>[
                IconButton(
                  splashColor: Colors.blueAccent.withOpacity(0.5),
                  color: Colors.blueAccent,
                  iconSize: 160.0,
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => LoginPage(
                                  type: vendeur,
                                )));
                  },
                  icon: Icon(Icons.apps),
                ),
                Text(
                  "Vendeur",
                  style: TextStyle(fontSize: 25.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
