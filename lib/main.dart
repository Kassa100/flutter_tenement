import 'package:flutter/material.dart';
import './common/StartPage.dart';
import './common/global.dart';
import './routes/App.dart';

void main() {
  // 在二进制执行前执行如下命令
  WidgetsFlutterBinding.ensureInitialized();

  // 渲染启动页
  bool state = true;
  if (state) {
    runApp(StartPage());
  }
  // 初始化操作
  Future.delayed(Duration(seconds: 2), () {
    Global.init().then((value) {
      state = false;
      runApp(MyApp());
    });
  });
}
