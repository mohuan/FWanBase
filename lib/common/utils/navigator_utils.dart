import 'package:flutter/material.dart';
import 'package:wanbase/page/login.dart';
import 'package:wanbase/page/home_page.dart';

///导航栏

class NavigatorUtils{
  ///主页
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }

  ///登录页
  static goLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.sName);
  }
}
