import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
