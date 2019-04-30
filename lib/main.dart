import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:leocher_app/ui/my_home_page.dart';
import 'package:leocher_app/ui/my_setting_page.dart';
import 'package:leocher_app/leocher.dart';

void main() => runApp(MyApp());

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => MyHomePage(),
  "/setting": (BuildContext context) => MySettingPage()
};


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "Leocher",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: routes,
      // showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false
    );
  }
}
