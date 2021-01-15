import 'package:flutter/material.dart';
import '../widgets/BottomNavWidget.dart';

class PersonalCenter extends StatefulWidget {
  PersonalCenter({Key key, this.title});
  final String title;
  @override
  PersonalCenterState createState() {
    return PersonalCenterState();
  }
}

class PersonalCenterState extends State<PersonalCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavWidget(
        select: 3,
      ),
      body: Container(
        child: Text('我的'),
      ),
    );
  }
}
