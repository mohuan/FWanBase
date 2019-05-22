import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wanbase/common/dao/user_dao.dart';
import 'package:wanbase/common/redux/base_state.dart';
import 'package:wanbase/common/style/base_style.dart';
import 'package:wanbase/common/utils/common_utils.dart';
import 'package:wanbase/common/utils/navigator_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends StatefulWidget{

  static final String sName = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();


}

class _WelcomePageState extends State<WelcomePage>{

  bool hadInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(hadInit){
      return;
    }
    hadInit = true;

    ///防止多次进入
    Store<BaseState> store = StoreProvider.of(context);
    CommonUtils.initStatusBarHeight(context);
    new Future.delayed(const Duration(seconds: 2,milliseconds: 2000),(){
      UserDao.initUserInfo(store).then((res) {
        if(res !=null && res.result){
          NavigatorUtils.goHome(context);
        }else{
          NavigatorUtils.goLogin(context);
        }
        return true;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return StoreBuilder<BaseState>(
      builder: (context,store){
        return new Container(
          color: Color(BaseColors.White),
          child: new Image(
            image: new AssetImage("images/welcome.png"),
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

