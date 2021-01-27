import 'package:flutter/material.dart';
import 'package:pill/screens/profile.dart';
import 'package:pill/screens/showprofile.dart';

class ProFileService extends StatefulWidget {
  @override
  _ProFileServiceState createState() => _ProFileServiceState();
}

class _ProFileServiceState extends State<ProFileService> {

  Widget currentWiget = ShowProfile();

  Widget addprofileButton() {
    return RaisedButton(
      color: Colors.blue.shade600,
      child: Text(
        'เพิ่ม/แก้ไข',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Profile());
        Navigator.push(context, route);
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('โปรไฟล์'),
        actions: <Widget>[
         addprofileButton(),
          
        ],
      ),
      body: currentWiget, 
      
     
    );
  }
}