import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pill/screens/showprofile.dart';
import 'package:pill/screens/showprofile_service.dart';
import 'package:pill/utility/my_style.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final formKey = GlobalKey<FormState>();
  String name, idcard, tel, dis, drug, hight, weight, doctor, urlPicProfile;

  double lat, lng;
  File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มโปรไฟล์'),
      ),
      body: Form(
        key: formKey,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                groupImage(),
                MyStyle().mySizebox(),
                nameForm(),
                MyStyle().mySizebox(),
                idcardForm(),
                MyStyle().mySizebox(),
                phoneForm(),
                MyStyle().mySizebox(),
                disForm(),
                MyStyle().mySizebox(),
                heightForm(),
                MyStyle().mySizebox(),
                drugForm(),
                MyStyle().mySizebox(),
                weightForm(),
                // MyStyle().mySizebox(),
                // clinicForm(),
                MyStyle().mySizebox(),
                docForm(),
                MyStyle().mySizebox(),
                confirmButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row groupImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_a_photo,
            size: 36.0,
          ),
          onPressed: () => chooseImage(ImageSource.camera),
        ),
        Container(
          width: 250.0,
          child: file == null
              ? Image.asset('images/profile.png')
              : Image.file(file),
        ),
        IconButton(
          icon: Icon(
            Icons.add_photo_alternate,
            size: 36.0,
          ),
          onPressed: () => chooseImage(ImageSource.gallery),
        )
      ],
    );
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxHeight: 800.0,
        maxWidth: 800.0,
      );
      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Widget confirmButton() => Container(
        width: 250.0,
        child: RaisedButton(
          color: MyStyle().buttonColor,
          onPressed: () {
            print('You Click Uplode');
            // if (formKey.currentState.validate()) {
            //   formKey.currentState.save();
            //   print(
            //       'name = $name, idcart = $idcard, phone = $tel, dis = $dis, height = $hight, weight = $weight,  doc = $doctor');
            // } else {
            //   //Up lode
            //   
            // }
            uplodePictureToFirebaseStorage();
          },
          child: Text(
            'ยืนยัน',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<void> uplodePictureToFirebaseStorage() async {
    Random random = Random();
    int q = random.nextInt(100000);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference reference =
        firebaseStorage.ref().child('Profile/picProfile$q.jpg');
    UploadTask storageUplodeTask = reference.putFile(file);

    var imageUrl = await (await storageUplodeTask).ref.getDownloadURL();
        urlPicProfile = imageUrl.toString();
    print(urlPicProfile);
    insertValueToFirestor();
  }

  Future<void> insertValueToFirestor() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;

    Map<String, dynamic> map = Map();
    map['Name'] = name;
    map['ID_Card'] = idcard;
    map['Tel '] = tel;
    map['Weight'] = weight;
    map['Hight'] = hight;
    map['Dis'] = dis;
    map['Drug'] = drug;
    map['Doctor'] = doctor;
    map['PicProfile'] = urlPicProfile;

    await fireStore.collection('Profile').document().setData(map).then((value) {
      print('Insert Sucsess');
      MaterialPageRoute route = MaterialPageRoute(
        builder: (value) => ProFileService(),
      );
      Navigator.of(context).pushAndRemoveUntil(route, (value) => false);
    });
  }

  Widget nameForm() {
    return TextFormField(
      style: TextStyle(color: Colors.purple),
      decoration: InputDecoration(
        icon: Icon(
          Icons.face,
          size: 48.0,
        ),
        labelText: 'ชื่อ-สกุล :',
        labelStyle:
            TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
        //helperText: 'กรอก ชื่อ-นามสกุลจริง',
        //helperStyle: TextStyle(
        //color: Colors.green.shade900,
        //fontStyle: FontStyle.italic,),
      ),
     
      onChanged: (String value) {
        name = value.trim();
      },
    );
  }

  Widget idcardForm() {
    return TextFormField(
      style: TextStyle(color: Colors.purple),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        icon: Icon(
          Icons.badge,
          size: 48.0,
        ),
        labelText: 'รหัสบัตรประชาชน :',
        labelStyle:
            TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
      ),
     
     
      onSaved: (String value) {
        idcard = value.trim();
      },
    );
  }

  Widget phoneForm() {
    return TextFormField(
      style: TextStyle(color: Colors.purple),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        icon: Icon(
          Icons.phone,
          size: 48.0,
        ),
        labelText: 'เบอร์โทรติดต่อ :',
        labelStyle:
            TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
      ),
     
      onSaved: (String value) {
        tel = value.trim();
      },
    );
  }

  Widget disForm() {
    return TextFormField(
      style: TextStyle(color: Colors.purple),
      decoration: InputDecoration(
        icon: Icon(
          Icons.device_thermostat,
          size: 48.0,
        ),
        labelText: 'โรคประจำตัว :',
        labelStyle:
            TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
      ),
     
      onSaved: (String value) {
        dis = value.trim();
      },
    );
  }

  Widget drugForm() {
    return TextFormField(
      style: TextStyle(color: Colors.purple),
      decoration: InputDecoration(
        icon: Icon(
          Icons.block,
          size: 48.0,
        ),
        labelText: 'แพ้ยา :',
        labelStyle:
            TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
      ),
    
      onSaved: (String value) {
        drug = value.trim();
      },
    );
  }

  Widget heightForm() {
    return TextFormField(
      style: TextStyle(color: Colors.purple),
      decoration: InputDecoration(
        icon: Icon(
          Icons.accessibility,
          size: 48.0,
        ),
        labelText: 'ส่วนสูง :',
        labelStyle:
            TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
      ),
     
      onSaved: (String value) {
        hight = value.trim();
      },
    );
  }

  Widget weightForm() {
    return TextFormField(
      style: TextStyle(color: Colors.purple),
      decoration: InputDecoration(
        icon: Icon(
          Icons.line_weight,
          size: 48.0,
        ),
        labelText: 'น้ำหนัก :',
        labelStyle:
            TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
      ),
    
      onSaved: (String value) {
        weight = value.trim();
      },
    );
  }

  // Widget clinicForm() {
  //   return TextFormField(
  //     style: TextStyle(color: Colors.purple),
  //     decoration: InputDecoration(
  //       icon: Icon(
  //         Icons.local_hospital,
  //         size: 48.0,
  //       ),
  //       labelText: 'คลินิกประจำตัว :',
  //       labelStyle:
  //           TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
  //     ),
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return 'กรุณากรอกข้อมูลให้ครบ';
  //       } else {
  //         return null;
  //       }
  //     },
  //     onSaved: (String value) {
  //       clinicString = value.trim();
  //     },
  //   );
  // }

  Widget docForm() {
    return TextFormField(
      style: TextStyle(color: Colors.purple),
      decoration: InputDecoration(
        icon: Icon(
          Icons.account_circle,
          size: 48.0,
        ),
        labelText: 'หมอประจำตัว :',
        labelStyle:
            TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
      ),
    
      onSaved: (String value) {
        doctor = value.trim();
      },
    );
  }
}
