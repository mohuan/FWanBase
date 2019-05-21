import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 颜色
class BaseColors{
  static const int White = 0xFFFFFFFF;
  static const int Black = 0xFF000000;
  static const int GrayA9A = 0xFF9A9A9A;
  static const int PrimaryColor = 0xFF498FE1;
}

class BaseConstant{
  //应该设置为常量 但为了适配
  static double lagerTextSize = ScreenUtil().setSp(70);


  static var lagerTextBlackBold = TextStyle(
    color: Color(BaseColors.Black),
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none
  );
}