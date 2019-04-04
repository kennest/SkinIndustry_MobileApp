import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: FlatButton(
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => SignupPage()));
              },
              child: Text('Sign Up'),
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
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Your Email",
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Your Password",
                  ),
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
                      'Log in',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CachedNetworkImage(
            height: 250.0,
            fit: BoxFit.cover,
            imageUrl:
                'https://3.bp.blogspot.com/-i3OIbIhSBcU/WevH6M1yPXI/AAAAAAAACDc/2_EtN0lcuAU0ubDtJ3khC0pMjAMysc2jQCEwYBhgL/s1600/IMG_9935.JPG',
            placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ],
      ),
    );
  }

  _onchanged() {}
}
