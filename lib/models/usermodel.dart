import 'dart:convert';

class UserModel {
  final String email;
  final String name;
  final String uid;
  final String namepill;
  final String detail;
  final String photo;


  UserModel({
    this.email,
    this.name,
    this.uid,
    this.namepill,
    this.detail,
    this.photo,
  });

  UserModel copyWith({
    String email,
    String name,
    String uid,
    String namepill,
    String detail,
    String photo,
  }) {
    return UserModel(
      namepill: namepill ?? this.namepill,
      detail: detail ?? this.detail,
      photo: photo ?? this.detail,
      email: email ?? this.email,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'uid': uid,
      'namepill': namepill,
      'detail': detail,
      'photo': photo,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return UserModel(
      email: map['email'],
      name: map['name'],
      uid: map['uid'],
      namepill: map['namepill'],
      detail: map['detail'],
      photo: map['photo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(email: $email, name: $name, uid: $uid, namepill: $namepill, detail: $detail, photo: $photo)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is UserModel &&
      o.email == email &&
      o.name == name &&
      o.uid == uid&&
      o.namepill == namepill&&
      o.detail == detail&&
      o.photo == photo;
      
  }

  @override
  int get hashCode => email.hashCode ^ name.hashCode ^ uid.hashCode ^ namepill.hashCode ^ detail.hashCode ^ photo.hashCode;
}