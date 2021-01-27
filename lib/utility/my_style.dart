import 'package:flutter/material.dart';

class MyStyle {

    InputDecoration inputDecoration(String string, Icon icon) => InputDecoration(
        labelText: string,
        prefixIcon: icon,
      );

  Color darkColor = Colors.blue.shade800;
  Color primaryColor = Colors.white;
  Color buttonColor = Colors.red.shade600;
  SizedBox mySizebox() => SizedBox(width: 8.0, height: 16.0,);

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 50.0,
          color: Colors.blue.shade800,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontFamily: 'chilanka',
        ),
      );

  Container showLogo() {
    return Container(
      width: 120.0,
      child: Image.asset('images/logo1.png'),
    );
  }

  Container showLogo1() {
    return Container(
      width: 120.0,
      child: Image.asset('images/logo1.png'),
    );
  }

  Container showLogo2() {
    return Container(
      width: 80.0,height: 80.0,
      child: Image.asset('images/logo1.png'),
    );
  }

  MyStyle();
}
