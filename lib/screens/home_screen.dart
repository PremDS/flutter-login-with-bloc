import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloclogin/bloc/login_bloc.dart';
import 'package:flutterbloclogin/bloc/login_event.dart';
import 'package:flutterbloclogin/bloc/login_state.dart';
import 'package:flutterbloclogin/screens/auth/login_screen.dart';
import 'package:flutterbloclogin/screens/dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Navigator.of(context).pop();
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc()..add(AppLoadEvent()),
        child: Center(
          child: BlocBuilder<LoginBloc, LoginState> (
            builder: (context, state){
              if(state is InitialState) {
                  return const Center(child: Text('Initial'),);
              } else if (state is LoggedInState) {
                  return DashboardScreen(userProfile: state.userProfile,);
              } 
              else if(state is LoginLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.blue,),
                );
              } else if(state is LoggedOutState) {
                  return LoginScreen();
              } else {
                  return const Center(child: Text('error'),);
              }
            },
            
          )
        ),
      ),
    );
  }
}
