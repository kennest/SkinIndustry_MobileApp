import 'package:flutter/material.dart';

class CategoryGrid extends StatefulWidget {
  final String category;

  CategoryGrid({Key key, this.category}) : super(key: key);

  _CategoryGridState createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  @override
  Widget build(BuildContext context) {
    return  GridView.extent(
      controller: ScrollController(),
        shrinkWrap: true,
        physics: ScrollPhysics(),
          maxCrossAxisExtent: 100.0,
          // Generate 100 Widgets that display their index in the List
          children: List.generate(100, (index) {
            return Center(
              child: Text(
                'Item $index',
                style: Theme.of(context).textTheme.headline,
              ),
            );
          }),
        );
  }

  Widget category_item() {}
}
