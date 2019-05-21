import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wanbase/common/redux/base_state.dart';
import 'package:wanbase/common/model/User.dart';
import 'package:wanbase/page/welcome.dart';
import 'package:wanbase/page/login.dart';

void main(){
  runZoned(() {
    runApp(FlutterReduxApp());
    PaintingBinding.instance.imageCache.maximumSize = 100;
  },onError: (Object obj,StackTrace stack){
    print(obj);
    print(stack);
  });
}

class FlutterReduxApp extends StatelessWidget{
  /// 创建Store，引用 BaseState 中的 appReducer 实现 Reducer 方法
  /// initialState 初始化 State
  final store = new Store<BaseState>(
    appReducer,
    middleware: middleware,

    ///初始化数据
    initialState: new BaseState(userInfo: User.empty())
  );

  FlutterReduxApp({Key key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    /// 通过 StoreProvider 应用 store
    return new StoreProvider(
        store: store,
        child: new StoreBuilder<BaseState>(builder: (context,store) {
          return new MaterialApp(
            routes: {
              WelcomePage.sName:(context){
                return WelcomePage();
              },
              LoginPage.sName:(context){
                return new LoginPage();
              }
            },
          );
        })
    );
  }
}




