import 'package:flutter/material.dart';
import '../widgets/BottomNavWidget.dart';

class CollectListPage extends StatefulWidget {
  CollectListPage({Key key, this.title});
  final String title;
  @override
  CollectListPageState createState() {
    return CollectListPageState();
  }
}

class CollectListPageState extends State<CollectListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavWidget(
        select: 2,
      ),
      body: Container(
        child: Text('收藏'),
      ),
    );
  }
}
