import 'package:redux/redux.dart';
import 'package:wanbase/common/local/LocalStorage.dart';
import 'package:wanbase/common/config/Config.dart';
import 'dart:convert';
import 'package:wanbase/common/model/User.dart';
import 'package:wanbase/common/dao/dao_result.dart';
import 'package:wanbase/common/redux/user_redux.dart';

class UserDao {
  static login(userName,password,store) async {

  }


  ///初始化用户信息
  static initUserInfo(Store store) async {
     var token = await LocalStorage.get(Config.TOKEN_KEY);
     var res = await getUserInfoLocal();
     if(res != null && res.result && token != null){
       store.dispatch(UpdateUserAction(res.data));
     }

     return new DataResult(res.data, (res.result && (token != null)));
  }

  //
  static getUserInfoLocal() async {
    var userText = await LocalStorage.get(Config.USER_INFO);
    if(userText !=null){
      var userMap = json.decode(userText);
      User user = User.fromJson(userMap);
      return new DataResult(user, true);
    }else{
      return new DataResult(null, false);
    }
  }
}

