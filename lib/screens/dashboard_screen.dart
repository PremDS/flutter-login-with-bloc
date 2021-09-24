import 'package:flutter/material.dart';
import 'package:flutterbloclogin/model/user_profile.dart';

class DashboardScreen extends StatefulWidget {
  UserProfile  userProfile;
  DashboardScreen({Key? key, required this.userProfile}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    Navigator.of(context).pop();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: const Text(
          'Hamro Learning',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Text('Welcome', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),),
      ),
    );
  }
}
