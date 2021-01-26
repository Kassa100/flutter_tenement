import 'package:flutter/material.dart';
import '../widgets/BottomNavWidget.dart';

class OrderListPage extends StatefulWidget {
  OrderListPage({Key key, this.title});
  final String title;
  @override
  OrderListPageState createState() {
    return OrderListPageState();
  }
}

class OrderListPageState extends State<OrderListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavWidget(
        select: 1,
      ),
      body: Container(
        child: Text('首页'),
      ),
    );
  }
}
