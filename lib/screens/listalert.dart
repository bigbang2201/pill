import 'package:flutter/material.dart';

class ListAlert extends StatefulWidget {
  @override
  _ListAlertState createState() => _ListAlertState();
}

class _ListAlertState extends State<ListAlert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการแจ้งเตือน'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              
            ],
          ),
        ),
      ),
    );
  }
}