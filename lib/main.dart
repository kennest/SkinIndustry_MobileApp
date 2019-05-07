import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_ecommerce/database/db_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'pages/pages.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(stacktrace.toString());
    print(error);
  }
}

void main() {
  getPermissions();
  BlocSupervisor().delegate = SimpleBlocDelegate();
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
    return MaterialApp(
      title: 'Perfect Skin Industry .Inc',
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
