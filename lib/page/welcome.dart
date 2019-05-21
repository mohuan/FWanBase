import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wanbase/common/dao/user_dao.dart';
import 'package:wanbase/common/redux/base_state.dart';
import 'package:wanbase/common/style/BaseColors.dart';
import 'package:wanbase/common/utils/common_utils.dart';
import 'package:wanbase/common/utils/navigator_utils.dart';

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
    return StoreBuilder<BaseState>(
      builder: (context,store){
        return new Container(
          color: Color(BaseColors.white),
          child: new Image(
            image: new AssetImage("images/welcome.png"),
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

