import 'package:flutter/material.dart';
import 'package:wanbase/page/login.dart';

class WelcomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
          title: '玩',
          theme: ThemeData(
            primaryColor: Color(0xFF5699E7)
          ),
          home: WelcomePageHome(),
          routes: <String,WidgetBuilder>{
            '/LoginPage': (BuildContext context) => new LoginPanel()
          },
      );
  }
}

class WelcomePageHome extends StatefulWidget{

  @override
  State createState() => WelcomePageHomeState();
}

class WelcomePageHomeState extends State<WelcomePageHome>{

  @override
  void initState() {
    super.initState();
    _countDown();
  }

  // 倒计时跳转
  _countDown(){
    var _duration = new Duration(seconds: 3);
    new Future.delayed(_duration,_goPage);
  }

  //跳转到登录页面
  _goPage(){
    Navigator.of(context).pushReplacementNamed("/LoginPage");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: AssetImage("images/welcome.png"),
        fit: BoxFit.cover
      )
    );
  }
}