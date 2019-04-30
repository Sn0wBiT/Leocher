import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:launcher_assist/launcher_assist.dart';
import 'package:leocher_app/leocher.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  int numberOfInstalledApps = 0;
  dynamic installedApps;
  var wallpaper;
  int length = 3;
  ValueNotifier<int> pageIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    LauncherAssist.getAllApps().then((apps) {
      setState(() {
          numberOfInstalledApps = apps.length;
          installedApps = apps;
      });
    });
    //
    LauncherAssist.getWallpaper().then((imageData) {
      setState(() {
        wallpaper = imageData;
      });
    });
    //
  }

  Future<dynamic> _buildImage(String _package) async {
    String path = "assets/png_64/${_package}.png";
    return rootBundle.load(path).then((value) {
      return true;
    }).catchError((_) {
      return false;
    });
  }

  List<Widget> createListItem(BuildContext context, dynamic data, int page) {
    List<Widget> _returnList = new List<Widget>();
    // for
    if(data == null) return _returnList;
    int currentSize = 0;
    var offset = (page - 1) * rtGlobal.maxSize;
    bool isAddLeocherSetting = false;
    
    
    for(var i = offset; i < data.length; i++) {
      if(currentSize < rtGlobal.maxSize) {

        var _obj = GestureDetector(
          onTap: (){
            LauncherAssist.launchApp(data[i]['package']);            
          },
          child: Container(
            height: 16,
            child: Column(
              children: <Widget>[
                FutureBuilder<dynamic>(
                  future: _buildImage(data[i]['package']),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if(snapshot.data) {
                        return Image.asset("assets/png_64/${data[i]['package']}.png", fit: BoxFit.cover, width: RtGlobal.calcWidth(context, 16),);
                      } else {
                        return Image.memory(data[i]['icon'], 
                          fit: BoxFit.cover, 
                          width: RtGlobal.calcWidth(context, 16),
                        );  
                      }
                    } else {
                      return Image.memory(data[i]['icon'], 
                        fit: BoxFit.cover, 
                        width: RtGlobal.calcWidth(context, 16),
                      );
                    }
                  },
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: RtGlobal.calcWidth(context, 2)
                    ),
                    child: Text(data[i]['label'], 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 7
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        if(data[i]['label'] != "leocher_app") {
          if(data[i]['package'] != "com.google.android.videos" && data[i]['package'] != "com.google.android.play.games" && data[i]['package'] != "com.google.android.music" && 
          data[i]['package'] != "com.android.gallery3d" && data[i]['package'] != "com.google.android.talk") {
            _returnList.add(_obj);
            currentSize++;
            print(data[i]['package']);
          }
        }
        //
        if(offset == 0 && i == 10 && !isAddLeocherSetting) {
          var _obj = GestureDetector(
            onTap: (){
              // GOTO Leocher Setting Page
            },
            child: Container(
              height: 16,
              child: Column(
                children: <Widget>[
                  Image.asset("assets/png_64/com.android.settings.png",
                    fit: BoxFit.cover,
                    width: RtGlobal.calcWidth(context, 16),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: RtGlobal.calcWidth(context, 2)
                      ),
                      child: Text("Leocher Setting", 
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 7
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
          );
          _returnList.add(_obj);
          currentSize++;
          isAddLeocherSetting = true;
        }
        //END
      }
    }
    return _returnList;
  }

  Widget showPageView(BuildContext context) {
    List<Widget> _widgetList = new List<Widget>();
    if(installedApps == null) return PageView();
    var _length = installedApps.length;
    var _pageCnt = (_length / rtGlobal.maxSize).round();
    length = _pageCnt;
    for(var i = 0; i < _pageCnt; i++) {
      var _obj = GridView.count(
        crossAxisSpacing: 10.0,
        crossAxisCount: 3,
        childAspectRatio: 1,
        children: createListItem(context, installedApps, i+1),
      );
      _widgetList.add(_obj);
    }

    var _pageView = PageView(
      onPageChanged: (index) => pageIndexNotifier.value = index,
      children: _widgetList,
    );
    return _pageView;
  }

  PageViewIndicator _mainPageIndicator() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: length,
      indicatorPadding: const EdgeInsets.all(4.0),
      normalBuilder: (animationController, index) => Circle(
        size: RtGlobal.calcWidth(context, 2.6),
        color: Colors.grey[600],
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: RtGlobal.calcWidth(context, 2.6),
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              rtGlobal.isUseWallpaper ? wallpaper != null ? new Image.memory(wallpaper, fit: BoxFit.cover,colorBlendMode: BlendMode.darken,) : new Center() : new Center(),
              Container(
                child: Row(
                  children: <Widget>[
                    
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: RtGlobal.calcWidth(context, 5),
                  right: RtGlobal.calcWidth(context, 5),
                  top: RtGlobal.calcWidth(context, 5),
                  bottom: RtGlobal.calcWidth(context, 5)
                ),
                child: showPageView(context),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: RtGlobal.calcWidth(context, 100),
                ),
                child:  _mainPageIndicator(),
              )
            ],
          ), // 
        )
      );
  }
}
