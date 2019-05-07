import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class DashBoardPage extends StatefulWidget {
  DashBoardPage({Key key}) : super(key: key);

  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  File _image;
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

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
            FormBuilderInput.segmentedControl(
              decoration: InputDecoration(
                  labelText: "Quantite",
                  fillColor: Colors.pink[400],
                  border: InputBorder.none),
              attribute: "quantite",
              // value: 2,
              require: true,
              options: List.generate(5, (i) => i + 1)
                  .map((number) => FormBuilderInputOption(value: number))
                  .toList(),
            ),
            FormBuilderInput.stepper(
              decoration: InputDecoration(labelText: "Stepper"),
              attribute: "stepper",
              value: 10,
              step: 1,
            ),
          ]),
          MaterialButton(
            color: Colors.pink[500],
            textColor: Colors.white,
            child: Text('Enregistrer'),
            onPressed: () {},
          ),
          Container(
          height: 250.0,
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[300],
        onPressed: _goToTheLake,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
