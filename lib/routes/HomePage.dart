import 'package:flutter/material.dart';
import '../widgets/BottomNavWidget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title});
  final String title;
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavWidget(
        select: 0,
      ),
      body: Container(
        child: Text('首页'),
      ),
    );
  }
}
