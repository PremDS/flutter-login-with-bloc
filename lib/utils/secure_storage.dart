import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterbloclogin/screens/home_screen.dart';

final FlutterSecureStorage secureStorage = FlutterSecureStorage();

class LocalStorage {
  static checkLogIn() async {
    final String? accessToken = await secureStorage.read(key: 'access-token');
    if (accessToken == null) {
      return false;
    }  else {
      return true;
    }
  }
  static saveLoginCredentials(accessToken) async {
    await secureStorage.write(key: 'acess-token', value: accessToken);
  }

  static deleteLoginCrendentails() async {
    await secureStorage.deleteAll();
  }


}
