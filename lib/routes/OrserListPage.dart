import 'package:flutter/material.dart';
import '../widgets/BottomNavWidget.dart';

class OrserListPage extends StatefulWidget {
  OrserListPage({Key key, this.title});
  final String title;
  @override
  OrserListPageState createState() {
    return OrserListPageState();
  }
}

class OrserListPageState extends State<OrserListPage> {
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
