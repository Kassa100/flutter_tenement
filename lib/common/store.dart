import 'package:redux/redux.dart';

//actions动作分发(也就是在组件中真正执行函数)

class LocationAction {
  final payload;
  LocationAction({this.payload});
}

// state 为全局初始数据,或者全局数据

class AppState {
  String location;
  AppState({this.location});
  static AppState initialState() {
    return AppState(location: '深圳市');
  }

  AppState copyWith({location}) {
    return AppState(location: location ?? this.location);
  }
}

// reducer 真正实现数据改变的地方

AppState AppReducer(AppState state, dynamic action) {
  switch (action.runtimeType) {
    case LocationAction:
      {
        return state.copyWith(location: action.payload);
      }
  }
}

// 抛出store

Store AppStore =
    Store<AppState>(AppReducer, initialState: AppState.initialState());
