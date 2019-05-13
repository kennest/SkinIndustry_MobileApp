import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.black12,
            padding: EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 10.0),
            child: Text(
              "Suivre votre Performance",
              style: TextStyle(fontSize: 20.0, color: Colors.black54),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Ventes sur les 30 derniers jours"),
              FlatButton(
                highlightColor: Colors.pink[400],
                onPressed: () {},
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.pink[400],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "450 FCFA",
                style: TextStyle(fontSize: 30.0),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("0.3 % par rapport au 30 derniers jours"),
            ],
          ),
          Container(
            color: Colors.black12,
            padding: EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 10.0),
            margin: EdgeInsets.only(top: 20.0),
            child: Text(
              "Restez informé",
              style: TextStyle(fontSize: 20.0, color: Colors.black54),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  IconButton(
                    highlightColor: Colors.pink[400],
                    onPressed: () {},
                    icon: Icon(
                      Icons.web,
                      color: Colors.blue[400],
                    ),
                  ),
                  Text("Groupe Facebook")
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    highlightColor: Colors.pink[400],
                    onPressed: () {},
                    icon: Icon(
                      Icons.apps,
                      color: Colors.blue[400],
                    ),
                  ),
                  Text("Blog SkinIndustry")
                ],
              ),
              
            ],
          ),
          Container(
            color: Colors.black12,
            padding: EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 10.0),
            margin: EdgeInsets.only(top: 20.0),
            child: Text(
              "Prêt à vendre",
              style: TextStyle(fontSize: 20.0, color: Colors.black54),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  IconButton(
                    highlightColor: Colors.pink[400],
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_basket,
                      color: Colors.blue[400],
                    ),
                  ),
                  Text("Acheter sur Skin Industry")
                ],
              ),              
            ],
          ),
        ],
      ),
    );
  }
}
