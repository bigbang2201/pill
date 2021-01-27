class PillProfileModel {

  // Field
  String name;
  String idcard;
  String tel;
  String weight;
  String hight;
  String dis;
  String drug;
  String clinic;
  String doctor;
  String picprofile;

  // Method
  PillProfileModel(
  this.name,
  this.idcard,
  this.tel,
  this.weight,
  this.hight,
  this.dis,
  this.drug,
  this.clinic,
  this.doctor,
  this.picprofile,
  );

  PillProfileModel.formMap1(Map<String, dynamic> map) {
    name = map['Name'];
    idcard = map['ID_Card'];
    tel = map['Tel'];
    weight = map['Weight'];
    hight = map['Hight'];
    dis = map['Dis'];
    drug = map['Drug'];
    clinic = map['Clinnic'];
    doctor = map['Doctor'];
    picprofile = map['PicProfile'];

    
    
  }
  
}