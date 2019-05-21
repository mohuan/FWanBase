import 'package:wanbase/common/model/User.dart';
import 'package:wanbase/common/redux/user_redux.dart';
import 'package:wanbase/common/redux/middleware/epic_middleware.dart';
import 'package:redux/redux.dart';


/**
  * Redux 全局State
  */

/// 全局Redux store 的对象，保存State数据
class BaseState{
  /// 用户信息
  User userInfo;

  /// 构造方法
  BaseState({this.userInfo});
}

///创建 reducer
///源码中 Reducer 是一个方法 typedef State Reducer<State>(State state, dynamic action);
///我们自定义了 appReducer 用于创建 store
BaseState appReducer(BaseState state,action){
  return BaseState(
    ///通过 UserReducer 将 BaseState 内的 userInfo 和 action 关联在一起
    userInfo: UserReducer(state.userInfo,action)
  );
}

final List<Middleware<BaseState>> middleware = [
  EpicMiddleware<BaseState>(UserInfoEpic()),
  UserInfoMiddleware()
];

