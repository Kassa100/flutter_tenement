import 'dart:ffi';

import 'package:redux/redux.dart';

//actions动作分发(也就是在组件中真正执行函数)

class LocationAction {
  final payload;
  LocationAction({this.payload});
}

// 房源详情数据Action
class ProjectDetailAction{
  final payload;
  ProjectDetailAction({this.payload});
}

// state 为全局初始数据,或者全局数据

class AppState {
  String location;
  Map projectDetail;
  AppState({this.location,this.projectDetail});
  static AppState initialState() {
    return AppState(location: '深圳市',projectDetail:null,);
  }

  AppState copyWith({location,projectDetail}) {
    return AppState(
      location: location ?? this.location,
      projectDetail: projectDetail ?? this.projectDetail,
    );
  }



}

// reducer 真正实现数据改变的地方

AppState AppReducer(AppState state, dynamic action) {
  switch (action.runtimeType) {
    case LocationAction:
      {
        return state.copyWith(location: action.payload);
      }
    case ProjectDetailAction:
      {
        return state.copyWith(projectDetail: action.payload);
      }
    default:
      return state;
  }
}

// 抛出store

Store AppStore =
    Store<AppState>(AppReducer, initialState: AppState.initialState());
