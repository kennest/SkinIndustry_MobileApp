import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/pages.dart';
import 'package:permission_handler/permission_handler.dart';

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

void getPermissions()async{
  Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
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
