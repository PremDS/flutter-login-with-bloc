import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterbloclogin/screens/auth/login_page.dart';
import 'package:flutterbloclogin/screens/home_page.dart';

final FlutterSecureStorage secureStorage = FlutterSecureStorage();

class LocalStorage {
  static Future checkLogIn(BuildContext context) async {
    final String? accessToken = await secureStorage.read(key: 'access-token');
    // final String? refreshToken = await secureStorage.read(key: 'refresh-token');
    print(accessToken);
    
    //checking for logged in credentials
    if (accessToken == null) {
      Timer(
          const Duration(seconds: 1),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const HomePage())));
    } else {
      Timer(
        const Duration(seconds: 0), 
        ()=> Navigator.push(
          context, MaterialPageRoute(builder: (context)=> const LoginPage())
        )
      );
    }
  }
  static Future saveLoginCredentials(accessToken, refreshToken) async {
    await secureStorage.write(key: 'acess-token', value: accessToken);
    await secureStorage.write(key: 'refresh-token', value: refreshToken);
  }

  static Future deleteLoginCrendentails() async {
    await secureStorage.deleteAll();
  }


}
