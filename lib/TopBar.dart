import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  String title;
  TopBar(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(7),
      alignment: Alignment.center,
      width: double.infinity,
      child: Text(
        title,
        style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.w900),
      ),
    );
  }
}
