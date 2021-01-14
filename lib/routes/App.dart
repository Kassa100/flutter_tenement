import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '租房网',
      theme: ThemeData(
        // 主要色调
        primaryColor: Colors.white,
      ),
      // 路由表
      routes: {
        '/': (context) => Text('首页'),
        'personalCenter': (context) => Text('我的'),
        'orderListPage': (context) => Text('预约'),
        'collectListPage': (context) => Text('收藏'),
      },
      initialRoute: '/',
    );
  }
}
