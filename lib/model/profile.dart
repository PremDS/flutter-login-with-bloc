
import 'dart:ffi';

class Profile  {
  
  Profile({
    this.primaryEmail,
    this.fullName,
    this.level,
    this.phoneNumber, 
    this.phoneVerify,
    this.currentAddress,
    this.permanentAddrress,
    this.pointCounter,
    this.regDate,
    this.about,
    this.image
  });

  String? primaryEmail;
  String? fullName;
  String? level;
  String? phoneNumber;
  String? phoneVerify;
  String? currentAddress;
  String? permanentAddrress;
  String? pointCounter;
  DateTime? regDate;
  String? about;
  String? image;


  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    primaryEmail: json['primary_email'],
    fullName: json['full_name'],
    level: json['level'],
    phoneNumber:  json['phone_number'],
    phoneVerify: json['phone_verify'],
    currentAddress: json['current_address'],
    permanentAddrress: json['permanent_address'],
    pointCounter: json['point_counter'],
    regDate: DateTime.parse(json['reg_date']),
    about: json['about'],
    image: json['image']
  );

  Map<String,dynamic> toJson() => {
    "primary_email":primaryEmail,
    "full_name": fullName,
    "level":level,
    "phone_nuber":phoneNumber,
    "phone_verify":phoneVerify,
    "current_address":currentAddress,
    "permanent_address":permanentAddrress,
    "point_counter":pointCounter,
    "reg_date": "${regDate!.year.toString().padLeft(4, '0')}-${regDate!.month.toString().padLeft(2, '0')}-${regDate!.day.toString().padLeft(2, '0')}",
    "about":about,
    "image":image
  };

}