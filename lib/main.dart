
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_ecommerce/bloc/cart/cart_bloc.dart';
import 'package:mobile_ecommerce/bloc/products/product_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'pages/pages.dart';


void main() {
  getPermissions();
  runApp(MyApp());
}

void getPermissions() async {
  Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler()
      .requestPermissions([PermissionGroup.storage, PermissionGroup.camera]);
  permissions.forEach((p, s) {
      print("${p.toString()}/${s.toString()}");
  });
}

class MyApp extends StatelessWidget {
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => CartBloc()),
      ],
      child: MaterialApp(
        title: 'Perfect Skin Industry .Inc',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PageView(
          controller: pageController,
          children: <Widget>[SplashPage()],
        ),
      ),
    );
  }
}
