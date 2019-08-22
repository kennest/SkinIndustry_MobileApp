import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'pages.dart';

class LoginPage extends StatefulWidget {
  final String type;
  LoginPage({Key key, this.type}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/loginbg.jpeg'),fit: BoxFit.cover)
        ),
        child: ListView(
          children: <Widget>[
            Image.asset('images/logo.jpeg',fit: BoxFit.contain,width: 90.0,height: 90.0,),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "Quelle est votre adresse e-mail ?",
                      style: TextStyle(fontSize: 20.0,color: Colors.pink[400]),textAlign: TextAlign.center,
                    ),
                    subtitle: Text('Entrez votre adresse e-mail pour vous connecter ou créer votre compte',
                      style: TextStyle(fontSize: 15.0),textAlign: TextAlign.center,),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
              child: Column(
                children: <Widget>[

                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Your Email",
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),

                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Switch(
                              onChanged: _onchanged(),
                              value: true,
                              activeColor: Colors.pinkAccent,
                            ),
                            Text('Remember me')
                          ],
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text('Forgot?'),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 300.0,
                    height: 50.0,
                    child: RaisedButton(
                      color: Colors.pink,
                      onPressed: () {
                        if (widget.type == "client") {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => ShoppingPage()));
                        } else {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => DashBoardPage()));
                        }
                      },
                      child: Text(
                        'Suivant',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => SignupPage()));
                    },
                    textColor: Colors.pink[400],
                    child: Text("Créer un compte"),
                  ),
                  RaisedButton(
                    color: Colors.blue[400],
                    onPressed: () {
                    },
                    child: Text(
                      'Continuer avec Facebook',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  _onchanged() {}
}
