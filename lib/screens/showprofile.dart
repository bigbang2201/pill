import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pill/models/pillprofile_model.dart';
import 'package:flutter/material.dart';
import 'package:pill/screens/profile.dart';
import 'package:pill/utility/my_style.dart';

class ShowProfile extends StatefulWidget {
  @override
  _ShowProfileState createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  // Field
  List<PillProfileModel> pillProfileModels = List();

  // Method
  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionReference = firestore.collection('Profile');
    await collectionReference.snapshots().listen((response) {
      Iterable<DocumentSnapshot> snapshots = response.documents;
      for (var snapshot in snapshots) {
        print('snapshot = $snapshot');
        print('Data = ${snapshot.data()}');

        PillProfileModel pillProfileModel =
            PillProfileModel.formMap1(snapshot.data());
        setState(() {
          pillProfileModels.add(pillProfileModel);
        });
      }
    });
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            image: DecorationImage(
              image: NetworkImage(pillProfileModels[index].picprofile),
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget showName(int index) {
    return Container(
      child: Text(
        'ชื่อ - สกุล: ${pillProfileModels[index].name}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget showID(int index) {
    return Container(
      child: Text(
        'รหัสบัตรประชาชน:' '${pillProfileModels[index].idcard}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget showTel(int index) {
    return Container(
      child: Text(
        'เบอร์โทรศัพท์:'' ${pillProfileModels[index].tel}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget showWeight(int index) {
    return Container(
      child: Text(
        'น้ำหนัก:' '${pillProfileModels[index].weight}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget showHight(int index) {
    return Container(
      child: Text(
        'ส่วนสูง:' '${pillProfileModels[index].hight}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget showDis(int index) {
    return Container(
      child: Text(
        'โรคประจำตัว:' '${pillProfileModels[index].dis}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget showDrug(int index) {
    return Container(
      child: Text(
        'แพ้ยา:'' ${pillProfileModels[index].drug}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget showDoctor(int index) {
    return Container(
      child: Text(
        'หมอประจำ:'' ${pillProfileModels[index].doctor}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget showText(int index) {
    return Container(
      padding: EdgeInsets.only(right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          showName(index),
          showID(index),
          showTel(index),
          showWeight(index),
          showHight(index),
          showDis(index),
          showDrug(index),
          showDoctor(index),
        ],
      ),
    );
  }

  Widget showListViwe(int index) {
    return Column(
      children: <Widget>[
        showImage(index),
        showText(index),
        
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: pillProfileModels.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return showListViwe(index);
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('ShowProfile'),
  //     ),
  //     body: Container(
  //       child: ListView.builder(
  //         itemCount: pillProfileModels.length,
  //         itemBuilder: (BuildContext buildContext, int index) {
  //           return showListViwe(index);
  //         },
  //       ),
  //     ),
  //   );
  // }

  
}
