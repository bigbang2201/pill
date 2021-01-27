import 'package:flutter/material.dart';

class HistoryPill extends StatefulWidget {
  @override
  _HistoryPillState createState() => _HistoryPillState();
}

class _HistoryPillState extends State<HistoryPill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ประวัติการใช้ยา'),
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