import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wanbase/common/redux/base_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanbase/common/style/BaseColors.dart';
import 'package:wanbase/widget/base_input_widget.dart';
import 'package:wanbase/widget/base_flex_button.dart';
import 'package:wanbase/common/utils/common_utils.dart';
import 'package:wanbase/common/dao/user_dao.dart';
import 'package:wanbase/common/utils/navigator_utils.dart';

///登录页面
class LoginPage extends StatefulWidget{

  static final String sName = "login";

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  var _userName = "";
  var _password = "";

  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<BaseState>(builder: (context,store){
      return new GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          body: new Container(
            color: Color(BaseColors.White),
            padding: new EdgeInsets.only(
              top: ScreenUtil().setHeight(140.0),
              left: ScreenUtil().setWidth(70.0),
              right: ScreenUtil().setWidth(70.0),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  "欢迎登陆",
                  style: TextStyle(
                      color: Color(BaseColors.Black),
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      fontSize:ScreenUtil().setSp(70)
                  ),
                ),

                new Text(
                  "考试报名，更简单",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(26),
                      color: Color(BaseColors.GrayA9A),
                      decoration: TextDecoration.none
                  ),
                ),

                new Padding(padding: new EdgeInsets.only(top: ScreenUtil().setHeight(110))),

                new BaseInputWidget(
                  hintText: "手机号或用户名",
                  onChanged: (String value){
                    _userName = value;
                  },
                  controller: userController,
                ),

                new BaseInputWidget(
                  hintText: "密码",
                  onChanged: (String value){
                    _password = value;
                  },
                  controller: pwController,
                ),

                new Padding(padding: new EdgeInsets.only(top: ScreenUtil().setHeight(135))),

                new BaseFlexButton(
                  text: "登录",
                  color: Color(BaseColors.PrimaryColor),
                  textColor: Color(BaseColors.White),
                  onPress: (){
                    if (_userName == null || _userName.length == 0) {
                      return;
                    }
                    if (_password == null || _password.length == 0) {
                      return;
                    }
                    CommonUtils.showLoadingDialog(context);

                    UserDao.login("", "", store).then((res) {
                      Navigator.pop(context);
                      if (res != null && res.result) {
                        new Future.delayed(const Duration(seconds: 1), () {
                          NavigatorUtils.goHome(context);
                          return true;
                        });
                      }
                    });
                  },
                ),


              ],
            ),
          ),
        ),
      );
    });
  }
}