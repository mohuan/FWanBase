import 'package:wanbase/common/config/config.dart';

///地址数据
class Address {
  static const String host = "http://exam-dev.skyworthedu.com:9009/api";

  ///登录  post
  static getAuth(){
    return "${host}/user/auth";
  }
}
