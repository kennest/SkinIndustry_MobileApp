import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages.dart';
class SignupPage extends StatefulWidget {

  SignupPage({Key key}) : super(key: key);

  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Créer votre compte !",
                    style: TextStyle(fontSize: 30.0),
                  ),
                  subtitle: Text('Remplissez les champs ci-dessous et on y va',
                      style: TextStyle(fontSize: 15.0)),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
            child: Column(
              children: <Widget>[
                 TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Your Username",
                  ),
                ),
                 SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Your Email",
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Your Password",
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                 TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Your Number",
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: 300.0,
                  height: 50.0,
                  child:  RaisedButton(
                  color: Colors.pink,
                  onPressed: (){
                     Navigator.push(context, CupertinoPageRoute(
                          builder: (context)=>ShoppingPage()
                        ));
                  },
                  child: Text('Créer',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                ),
                ),
                  
              ],
            ),
          ),
           Container(
                  height: 200.0,
                  margin: EdgeInsets.only(top: 25.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/ebene.jpg'),
                      fit: BoxFit.cover
                    )
                  ),
                ) 
        ],
      ),
    );
  }
}