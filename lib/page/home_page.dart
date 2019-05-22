import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';


///主页

class HomePage extends StatefulWidget{

  static final String sName = "home";

  @override
  State createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{

  int _selectedIndex = 1;

  /// 不退出
  Future<bool> _dialogExitApp(BuildContext context) async {
    if(Platform.isAndroid){
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }
    return Future.value(false);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: Scaffold(
        appBar: AppBar( //导航栏
          title: Text("App Name"),
          actions: <Widget>[ //导航栏右侧菜单
            IconButton(icon: Icon(Icons.share), onPressed: () {}),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar( // 底部导航
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
            BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('历史成绩')),
            BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('我的')),
          ],
          currentIndex: _selectedIndex,
          fixedColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );


  }

}