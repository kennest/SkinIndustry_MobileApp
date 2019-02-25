import 'package:flutter/material.dart';
import 'pages/pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageView(
        controller: pageController,
        children: <Widget>[SplashPage()],
      ),
    );
  }
}
