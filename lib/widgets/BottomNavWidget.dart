import 'package:flutter/material.dart';

class BottomNavWidget extends StatefulWidget {
  int select;
  BottomNavWidget({Key key, this.select});
  @override
  _BottomNavWidgetState createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // 选中的颜色
      selectedItemColor: Colors.blue,
      // 未选中颜色
      unselectedItemColor: Color(0xff666666),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
        BottomNavigationBarItem(icon: Icon(Icons.business), label: '预约'),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: '收藏'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: '我的'),
      ],
      // 索引
      currentIndex: widget.select,
      // 按钮布局
      type: BottomNavigationBarType.fixed,
      // 事件
      onTap: (int index) {
        switch (index) {
          case 0:
            {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            }
            break;
          case 1:
            {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'orderListPage', (route) => false);
            }
            break;
          case 2:
            {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'collectListPage', (route) => false);
            }
            break;
          case 3:
            {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'personalCenter', (route) => false);
            }
            break;
        }
      },
    );
  }
}
