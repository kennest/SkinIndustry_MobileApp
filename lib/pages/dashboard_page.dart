import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_ecommerce/pages/dashboard/home.dart';
import 'package:mobile_ecommerce/pages/dashboard/team.dart';
import 'package:mobile_ecommerce/pages/dashboard/you.dart';

class DashBoardPage extends StatefulWidget {
  DashBoardPage({Key key}) : super(key: key);

  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
PageController _pageController=PageController();
var _index=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[500],
        title: Text("Plateforme SkinIndustry"),
      ),
      body:PageView(
        controller: _pageController,
        children: <Widget>[
          HomePage(),
          TeamPage(),
          YouPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
           _pageController.animateToPage(index,curve: Curves.ease,duration: Duration(seconds: 1));
           setState(() {
             _index=index;
           });
        },
        selectedItemColor: Colors.pink[400],
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("Accueil")),
          BottomNavigationBarItem(icon: Icon(Icons.group_work),title: Text("Equipe")),
          BottomNavigationBarItem(icon: Icon(Icons.verified_user),title: Text("Vous"))
        ],
      ),
    );
  }

}
