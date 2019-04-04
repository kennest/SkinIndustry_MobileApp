import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class DashBoardPage extends StatefulWidget {
  DashBoardPage({Key key}) : super(key: key);

  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: ListView(
        children: <Widget>[
          FormBuilder(context, autovalidate: true, controls: [
            FormBuilderInput.textField(
              type: FormBuilderInput.TYPE_TEXT,
              attribute: "name",
              decoration: InputDecoration(labelText: "Name"),
              require: true,
              min: 3,
            ),
            FormBuilderInput.dropdown(
              decoration: InputDecoration(labelText: "Option"),
              attribute: "dropdown",
              require: true,
              options: [
                FormBuilderInputOption(value: "Option 1"),
                FormBuilderInputOption(value: "Option 2"),
                FormBuilderInputOption(value: "Option 3"),
              ],
            )
          ]),
          AnimatedCircularChart(
            key: _chartKey,
            size: const Size(300.0, 300.0),
            initialChartData: <CircularStackEntry>[
              new CircularStackEntry(
                <CircularSegmentEntry>[
                  new CircularSegmentEntry(
                    33.33,
                    Colors.blue[400],
                    rankKey: 'completed',
                  ),
                  new CircularSegmentEntry(
                    66.67,
                    Colors.blueGrey[600],
                    rankKey: 'remaining',
                  ),
                ],
                rankKey: 'progress',
              ),
            ],
            chartType: CircularChartType.Radial,
            percentageValues: true,
            holeLabel: '1/3',
            labelStyle: new TextStyle(
              color: Colors.blueGrey[600],
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          )
        ],
      ),
    );
  }
}
