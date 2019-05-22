import 'package:dio/dio.dart';
import 'package:wanbase/common/config/config.dart';
import 'package:wanbase/common/local/local_storage.dart';
import 'package:wanbase/common/net/api.dart';
import 'package:wanbase/common/utils/common_utils.dart';

///Token拦截器
class TokenInterceptors extends InterceptorsWrapper {

  String _ticket;

  @override
  onRequest(RequestOptions options) async {
    //授权码
    if (_ticket == null) {
      var _ticketCode = await getAuthorizationTicket();
      if (_ticketCode != null) {
        _ticket = _ticketCode;

        options.headers["ticket"] = _ticket;
      }
    }

    options.headers["Content-Type"] = HttpManager.CONTENT_TYPE_JSON;
    options.headers["sid"] = CommonUtils.getUuid();
    return options;
  }


  @override
  onResponse(Response response) async{
    try {
//      var responseJson = response.data;
//      if (response.statusCode == 201 && responseJson["token"] != null) {
//        _token = 'token ' + responseJson["token"];
//        await LocalStorage.save(Config.TOKEN_KEY, _token);
//      }
    } catch (e) {
      print(e);
    }
    return response;
  }

  ///清除授权
  clearAuthorization() {
    this._ticket = null;
    LocalStorage.remove(Config.TICKET_KEY);
  }

  ///获取授权ticket
  getAuthorizationTicket() async {
    String ticket = await LocalStorage.get(Config.TICKET_KEY);
    if (ticket == null) {
      String basic = await LocalStorage.get(Config.TICKET_KEY);  //  qwe USER_BASIC_CODE
      if (basic == null) {
        //提示输入账号密码
      } else {
        //通过 basic 去获取token，获取到设置，返回token
//        return "Basic $basic";
        return basic;
      }
    } else {
      this._ticket = ticket;
      return ticket;
    }
  }
}