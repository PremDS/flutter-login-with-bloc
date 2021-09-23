import 'dart:convert';
import 'package:flutterbloclogin/model/profile.dart';


class UserProfile {
  UserProfile({this.status, this.message, this.profile});
  String? status;
  String? message;
  Profile? profile;


  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile (
    status: json['status'],
    message: json['message'],
    profile: Profile.fromJson(json["profile"]
    )
  );

  Map<String, dynamic> toJson()=> {
    "status":status,
    "message":message,
    "profile":profile!.toJson(),
  };

}
