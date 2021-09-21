import 'package:flutter/material.dart';
import 'package:flutterbloclogin/screens/home_page.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({ Key? key }) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 8,
      navigateAfterSeconds: HomePage(),
      title: Text('Flutter Login',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),),
      image: Image.asset('assets/images/logo.png'),
      loadingText: Text('By Prem Tamang', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.purpleAccent),),
      backgroundColor: Colors.white,
      photoSize: 100.0,
      loaderColor: Colors.purpleAccent,
      
    );
  }
}