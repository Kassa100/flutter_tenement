import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset('assets/images/01.png'),
          Text(
            '租房网',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 24.0,
            ),
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
  }
}
