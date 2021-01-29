import 'package:flutter/material.dart';
import './HomePage.dart';
import './CollectListPage.dart';
import './OrderListPage.dart';
import './PersonalCenter.dart';
import './ProjectList.dart';
import './ProjectDetail.dart';
import './LoginPage.dart';
import './RegisterPage.dart';
import './PersonalInformation.dart';
import './PersonalInformationChange.dart';
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
        'personalInformationChange': (context) => PersonalInformationChange(title: '个人信息修改',arg: ModalRoute.of(context).settings.arguments,),
        'personalInformation': (context) => PersonalInformation(title: '个人信息'),
        'loginPage': (context) => LoginPage(),
        'registerPage': (context) => RegisterPage(),
        'projectList': (context) => ProjectList(
              title: '房源列表',
              arg: ModalRoute.of(context).settings.arguments,
            ),
        '/': (context) => HomePage(title: '首页'),
        'projectDetail': (context) => ProjectDetail(title: '房源详情'),
        'personalCenter': (context) => PersonalCenter(title: '我的'),
        'orderListPage': (context) => OrderListPage(title: '预约'),
        'collectListPage': (context) => CollectListPage(title: '收藏'),
      },
      initialRoute: '/',
    );
  }
}
