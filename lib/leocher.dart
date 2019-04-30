import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RtGlobal {
  bool isUseWallpaper = false;
  int maxSize = 12;
  
  RTGlobal()
  {
    print(TimeOfDay.now());
    getLauncherSetting();
  }

  Future getLauncherSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    isUseWallpaper = (prefs.getBool('isUseWallpaper') ?? false);
    
  }

  static double calcWidth(BuildContext context, double _percent)
  {
    double width = MediaQuery.of(context).size.width;
    return (width * _percent) / 100;
  }
  
  static double calcHeight(BuildContext context, double _percent) 
  {
    double height = MediaQuery.of(context).size.height;
    return (height * _percent) / 100;
  }
}
var rtGlobal = new RtGlobal();

/** OTHER **/
class ExitButton extends StatelessWidget {
  const ExitButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: const Tooltip(
        message: 'Back',
        child: Text('Exit'),
        excludeFromSemantics: true,
      ),
      onPressed: () {
        // The demo is on the root navigator.
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
  }
}
