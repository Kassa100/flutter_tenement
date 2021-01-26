import 'package:flutter/material.dart';
import './HomePage.dart';
import './CollectListPage.dart';
import './OrderListPage.dart';
import './PersonalCenter.dart';
import './ProjectList.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '租房网',
      theme: ThemeData(
        // 主要色调
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      // 路由表
      routes: {
        'projectList': (context) => ProjectList(
              title: '房源列表',
              arg: ModalRoute.of(context).settings.arguments,
            ),
        '/': (context) => HomePage(title: '首页'),
        'personalCenter': (context) => PersonalCenter(title: '我的'),
        'orderListPage': (context) => OrderListPage(title: '预约'),
        'collectListPage': (context) => CollectListPage(title: '收藏'),
      },
      initialRoute: '/',
    );
  }
}
