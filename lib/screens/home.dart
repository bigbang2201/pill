import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pill/screens/Example.dart';
import 'package:pill/screens/addpill.dart';
import 'package:pill/screens/history.dart';
import 'package:pill/screens/list1.dart';
import 'package:pill/screens/listalert.dart';
import 'package:pill/screens/showprofile_service.dart';
import 'package:pill/screens/signin.dart';
import 'package:pill/screens/signup.dart';
import 'package:pill/screens/showprofile.dart';
import 'package:pill/screens/start.dart';
import 'package:pill/utility/my_style.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Explicit
  Widget currentWiget = List1();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: <Widget>[
          signOutButton(),
          
        ],
      ),
      body: currentWiget,
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHeadDrawer(),
            //signInMenu(),
            //signUpMenu(),
            profileMenu(),
            addpillMenu(),
            // historypillMenu(),
            // listalertMenu(),
          ],
        ),
      );

  ListTile signInMenu() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('ล็อกอิน'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignIn());
        Navigator.push(context, route);
      },
    );
  }

  ListTile signUpMenu() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('สมัคร'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Register());
        Navigator.push(context, route);
      },
    );
  }

  ListTile profileMenu() {
    return ListTile(
      leading: Icon(
        Icons.account_circle,
        size: 35.0,
        color: Colors.blue[600],
      ),
      title: Text(
        'โปรไฟล์',
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text('เพิ่ม/แก้ไข ข้อมูลส่วนตัว'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => ProFileService());
        Navigator.push(context, route);
      },
    );
  }

  ListTile addpillMenu() {
    return ListTile(
      leading:
          Icon(Icons.add_alarm_rounded, size: 35.0, color: Colors.blue[600]),
      title: Text('เพิ่มการแจ้งเตือน',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          )),
      subtitle: Text('เพิ่มการแจ้งเตือนเวลาทานยา'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => AddPill());
        Navigator.push(context, route);
      },
    );
  }

  ListTile historypillMenu() {
    return ListTile(
      leading: Icon(Icons.list, size: 35.0, color: Colors.blue[600]),
      title: Text('ประวัติการใช้ยา',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          )),
      subtitle: Text('ตรวจสอบประวัติการใช้ยา'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => HistoryPill());
        Navigator.push(context, route);
      },
    );
  }

  ListTile listalertMenu() {
    return ListTile(
      leading: Icon(Icons.alarm, size: 35.0, color: Colors.blue[600]),
      title: Text('รายการแจ้งเตือน',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          )),
      subtitle: Text('ตรวจสอบรายการการแจ้งเตือน'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => ListAlert());
        Navigator.push(context, route);
      },
    );
  }

  Widget signOutButton() {
    return IconButton(
        icon: Icon(Icons.exit_to_app),
        tooltip: 'ออกจากระบบ',
        onPressed: () {
          myAlert();
        });
  }

  void myAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('คุณแน่ใจ ?'),
          content: Text('คุณต้องการออกจากระบบ ?'),
          actions: <Widget>[
            cancelButton(),
            okButton(),
          ],
        );
      },
    );
  }

  Widget okButton() {
    return FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
        processSignOut();
      },
    );
  }

  Future<void> processSignOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Start());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Widget cancelButton() {
    return FlatButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget showAppName() {
    return Text(
      'PILL APP FOR YOU',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget showHeadDrawer() {
    return DrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/blacegrandDrawer.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          MyStyle().showLogo2(),
          showAppName(),
        ],
      ),
    );
  }
}
