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
            alignment: Alignment.topRight,
            child: FlatButton(
               onPressed: (){
                     Navigator.push(context, CupertinoPageRoute(
                          builder: (context)=>LoginPage()
                        ));
                  },
              child: Text('Log In'),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Welcome Back !",
                    style: TextStyle(fontSize: 30.0),
                  ),
                  subtitle: Text('Log back into your account',
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
                  child: Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                ),
                ),
                  
              ],
            ),
          ),
           Container(
                  height: 150.0,
                  margin: EdgeInsets.only(top: 25.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://3.bp.blogspot.com/-i3OIbIhSBcU/WevH6M1yPXI/AAAAAAAACDc/2_EtN0lcuAU0ubDtJ3khC0pMjAMysc2jQCEwYBhgL/s1600/IMG_9935.JPG'),
                      fit: BoxFit.cover
                    )
                  ),
                ) 
        ],
      ),
    );
  }
}