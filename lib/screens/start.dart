import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pill/screens/Example.dart';
import 'package:pill/screens/home.dart';
import 'package:pill/screens/my_service.dart';
import 'package:pill/screens/signin.dart';
import 'package:pill/screens/signup.dart';
import 'package:pill/utility/my_style.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  //Method
  @override
  void initState() {
    super.initState();
    // checkStatus();
  }

  // Future<void> checkStatus() async {
  //   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //   var user = firebaseAuth.currentUser;
  //   if (user != null) {
  //     MaterialPageRoute materialPageRoute =
  //         MaterialPageRoute(builder: (BuildContext context) => Home());
  //     Navigator.of(context).pushAndRemoveUntil(
  //         materialPageRoute, (Route<dynamic> route) => false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PILL'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[Colors.white, MyStyle().primaryColor],
            center: Alignment(0, -0.3),
            radius: 0.0,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyStyle().showLogo(),
                //MyStyle().mySizebox(),
                //MyStyle().showTitle('Pill'),
                MyStyle().mySizebox(),
                showButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        signInButton(),
        MyStyle().mySizebox(),
        signUpButton(),
      ],
    );
  }

  Widget signUpButton() {
    return RaisedButton(
      color: Colors.blue.shade600,
      child: Text(
        'สมัครสมาชิก',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('You Click SignUp');
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Register());
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget signInButton() {
    return RaisedButton(
      color: Colors.blue.shade600,
      child: Text(
        'ลงชื่อเข้าใช้',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('You Click SignIn');
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => SignIn());
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }
}
