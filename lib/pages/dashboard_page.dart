import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:image_picker/image_picker.dart';

class DashBoardPage extends StatefulWidget {
  DashBoardPage({Key key}) : super(key: key);

  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[500],
        title: Text("Dashboard"),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(
                    _image,
                    fit: BoxFit.cover,
                    height: 250.0,
                    width: 500.0,
                  ),
          ),
          RaisedButton(
            onPressed: () {},
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
              child: IconButton(
                onPressed: () {
                  getImage();
                },
                icon: Icon(Icons.photo_camera),
              ),
            ),
          ),
          FormBuilder(context, autovalidate: true, controls: [
            FormBuilderInput.textField(
              type: FormBuilderInput.TYPE_TEXT,
              attribute: "name",
              decoration: InputDecoration(labelText: "Nom du produit"),
              require: true,
              min: 3,
            ),
            FormBuilderInput.textField(
              type: FormBuilderInput.TYPE_NUMBER,
              attribute: "price",
              decoration: InputDecoration(labelText: "Prix du produit"),
              require: true,
              min: 3,
            ),
            FormBuilderInput.datePicker(
              decoration: InputDecoration(labelText: "Date"),
              attribute: "time",
            ),
            FormBuilderInput.dropdown(
              decoration: InputDecoration(labelText: "Categorie"),
              attribute: "dropdown",
              require: true,
              options: [
                FormBuilderInputOption(value: "Savon", label: "SAVON"),
                FormBuilderInputOption(value: "Pommade"),
                FormBuilderInputOption(value: "Lotion"),
              ],
            ),
          ]),
          MaterialButton(
            color: Colors.pink[500],
            textColor: Colors.white,
            child: Text('Enregistrer'),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[300],
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
