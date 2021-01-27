import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pill/screens/home.dart';
import 'package:pill/screens/list1.dart';

class AddPill extends StatefulWidget {
  @override
  _AddPillState createState() => _AddPillState();
}

class _AddPillState extends State<AddPill> {
// Field
  File file;
  String namepill, detail, urlPicture;

// Method

  Widget uplodeButton() {
    return Container(
      child: RaisedButton.icon(
        color: Colors.teal[200],
        onPressed: () {
          print('You click');

          if (file == null) {
            showAlert('Non choose Picture', 'Please Click camera or Gallery');
          } else if (namepill == null ||
              namepill.isEmpty ||
              detail == null ||
              detail.isEmpty) {
            showAlert('Have Space', 'Please Fill Every Blank');
          } else {
            // Uplode Value To Firebase
            uplodePictureToStorage();
          }
        },
        icon: Icon(
          Icons.cloud_upload,
          color: Colors.white,
        ),
        label: Text('บันทึกข้อมูลยา'),
      ),
    );
  }

  Future<void> uplodePictureToStorage() async {
    Random random = Random();
    int i = random.nextInt(100000);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference storageReference =
        firebaseStorage.ref().child('Pill/product$i.jpg');
    UploadTask storageUplodeTask = storageReference.putFile(file);

    var imageUrl = await (await storageUplodeTask).ref.getDownloadURL();
    urlPicture = imageUrl.toString();
    print(urlPicture);
    insertValueToFireStore();
  }

  Future<void> insertValueToFireStore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Map<String, dynamic> map = Map();
    map['namepill'] = namepill;
    map['detail'] = detail;
    map['photo'] = urlPicture;

    await firestore.collection('user').document('L9dibj7HdvdN8q0ViPkDl53Zd3q2').setData(map).then((value) {
      print('Insert Sucsess');
      MaterialPageRoute route = MaterialPageRoute(
        builder: (value) => Home(),
      );
      Navigator.of(context).pushAndRemoveUntil(route, (value) => false);
    });
  }

  Future<void> showAlert(
    String title,
    String message,
  ) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              )
            ],
          );
        });
  }

  Widget nameForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextField(
        onChanged: (String string) {
          namepill = string.trim();
        },
        decoration: InputDecoration(
          helperText: 'ใส่ชื่อของ"ยา"ที่จะใช้เพื่อแจ้งเตือน',
          labelText: 'ชื่อยา',
          icon: Icon(
            Icons.favorite_border,
            size: 36.0,
          ),
        ),
      ),
    );
  }

  Widget detailForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextField(
        onChanged: (value) {
          detail = value.trim();
        },
        decoration: InputDecoration(
          helperText: 'ใส่รายละเอียดของ"ยา"ที่จะใช้เพื่อแจ้งเตือน',
          labelText: 'รายละเอียดยา',
          icon: Icon(
            Icons.list_alt,
            size: 36.0,
          ),
        ),
      ),
    );
  }

  Widget cameraButton() {
    return IconButton(
      icon: Icon(
        Icons.add_a_photo,
        size: 36.0,
      ),
      onPressed: () {
        chooseImage(ImageSource.camera);
      },
    );
  }

  Future<void> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );

      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Widget galleryButton() {
    return IconButton(
      icon: Icon(
        Icons.add_photo_alternate,
        size: 36.0,
      ),
      onPressed: () {
        chooseImage(ImageSource.gallery);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        cameraButton(),
        galleryButton(),
      ],
    );
  }

  Widget showImage() {
    return Container(
      padding: EdgeInsets.all(20.0),
      // color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: file == null ? Image.asset('images/pic1.png') : Image.file(file),
    );
  }

  Widget showContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        showImage(),
        showButton(),
        nameForm(),
        detailForm(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มการแจ้งเตือนยา'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              showContent(),
              uplodeButton(),
            ],
          ),
        ),
      ),
    );
  }
}
