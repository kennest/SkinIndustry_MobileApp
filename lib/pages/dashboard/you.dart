import 'package:flutter/material.dart';

class YouPage extends StatefulWidget {
  YouPage({Key key}) : super(key: key);

  _YouPageState createState() => _YouPageState();
}

class _YouPageState extends State<YouPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
       child: Text('You'),
    );
  }
}