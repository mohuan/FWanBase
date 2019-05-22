import 'package:redux/redux.dart';
import 'package:wanbase/common/local/local_storage.dart';
import 'package:wanbase/common/config/Config.dart';
import 'dart:convert';
import 'package:wanbase/common/model/User.dart';
import 'package:wanbase/common/dao/dao_result.dart';
import 'package:wanbase/common/redux/user_redux.dart';
import 'package:wanbase/common/net/api.dart';
import 'package:wanbase/common/net/address.dart';
import 'package:dio/dio.dart';

class UserDao {
  static login(userName,password,store) async {
    httpManager.clearAuthorization();

    Map requestParams = {
      "user": userName,
      "password": password,
    };

    var res = await httpManager.netFetch(Address.getAuth(), json.encode(requestParams), null, new Options(method: "post"));
    var resultData;
    if (res != null && res.result) {
      //await LocalStorage.save(Config.PW_KEY, password);
      var resultData = User.fromJson(res.data);
      //保存用户信息
      await LocalStorage.save(Config.USER_INFO, json.encode(resultData.toJson()));
      await LocalStorage.save(Config.TICKET_KEY, (resultData as User).ticket);
      if (Config.DEBUG) {
//        print("user result " + resultData.result.toString());
//        print(resultData.data);
        print(res.data.toString());
      }
      store.dispatch(new UpdateUserAction(resultData));
    }else{
      //错误
      return new DataResult(res.data, res.result);
    }
    return new DataResult(resultData, res.result);
  }


  ///初始化用户信息
  static initUserInfo(Store store) async {
     var ticket = await LocalStorage.get(Config.TICKET_KEY);
     var res = await getUserInfoLocal();
     if(res != null && res.result && ticket != null){
       store.dispatch(UpdateUserAction(res.data));
     }

     return new DataResult(res.data, (res.result && (ticket != null)));
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

