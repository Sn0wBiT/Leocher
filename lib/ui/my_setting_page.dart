import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:launcher_assist/launcher_assist.dart';
import 'package:leocher_app/leocher.dart';

class MySettingPage extends StatefulWidget {
  MySettingPage({Key key}) : super(key: key);

  _MySettingPageState createState() => _MySettingPageState();
}

class _MySettingPageState extends State<MySettingPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        trailing: ExitButton(),
      ),
      child: SafeArea(
        child: Text("Setting"),
      ),
    );
  }
}