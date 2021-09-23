import 'package:flutter/material.dart';
import 'package:flutterbloclogin/screens/home_page.dart';
import 'package:flutterbloclogin/screens/auth/login_page.dart';
import 'package:flutterbloclogin/utils/secure_storage.dart';

void main()=>runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login with Bloc Pattern',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
