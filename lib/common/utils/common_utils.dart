import 'package:flutter_statusbar/flutter_statusbar.dart';
import 'package:flutter/material.dart';
import 'package:wanbase/common/style/base_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wanbase/common/local/local_storage.dart';
import 'package:wanbase/common/config/Config.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

///通用逻辑
class CommonUtils{
  static double sStaticBarHeight = 0.0;

  static void initStatusBarHeight(context) async {
    sStaticBarHeight = await FlutterStatusbar.height / MediaQuery.of(context).devicePixelRatio;
  }

  //哈希
  static String slowHash (String s) {
    for (int i=0;i<10000;i++){
      s = generateMd5(s);
    }
    return s;
  }

  static String generateMd5(String data){
    if(data.isEmpty){
      return "";
    }
    // 3acc43cd50d9bcbe3757815439ff7d7b  flutter
    // 670b14728ad9902aecba32e22fa4f6bd  java
//    var content = new Utf8Encoder().convert(data);
//    var digest = md5.convert(content);
//    // 这里其实就是 digest.toString()
    return md5.convert(utf8.encode(data)).toString();
  }


  static Future<String> getUuid() async {
     String uuid = await LocalStorage.get(Config.UUID);
     if(uuid == null){
       DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
       if(Platform.isIOS){
         //ios相关代码
         IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
         uuid = iosInfo.identifierForVendor;
       }else if(Platform.isAndroid){
         //android相关代码
         AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
         uuid = androidInfo.fingerprint;
       }
       await LocalStorage.save(Config.UUID, uuid);
     }
     return uuid;
  }

  static Future<Null> showLoadingDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Material(
              color: Colors.transparent,
              child: WillPopScope(
                onWillPop: () => new Future.value(false),
                child: Center(
                  child: new Container(
                    width: 200.0,
                    height: 200.0,
                    padding: new EdgeInsets.all(4.0),
                    decoration: new BoxDecoration(
                      color: Colors.transparent,
                      //用一个BoxDecoration装饰器提供背景图片
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(child: SpinKitCubeGrid(color: Color(BaseColors.White))),
                        new Container(height: 10.0),
                        new Container(child: new Text("努力加载中···",
                            style: new TextStyle(
                              color: Color(BaseColors.White),
                              fontSize:ScreenUtil().setSp(18.0)
                            )
                        )),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}