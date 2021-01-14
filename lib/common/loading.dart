import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  Loading({Key key, this.color = Colors.black, this.opacity = 0.7});
  final color;
  final opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(color: color),
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
        ),
      ),
    );
  }
}
