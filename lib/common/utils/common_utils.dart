import 'package:flutter_statusbar/flutter_statusbar.dart';
import 'package:flutter/material.dart';


///通用逻辑
class CommonUtils{
  static double sStaticBarHeight = 0.0;

  static void initStatusBarHeight(context) async {
    sStaticBarHeight = await FlutterStatusbar.height / MediaQuery.of(context).devicePixelRatio;
  }
}