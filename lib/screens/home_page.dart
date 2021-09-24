import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloclogin/bloc/login_bloc.dart';
import 'package:flutterbloclogin/bloc/login_event.dart';
import 'package:flutterbloclogin/bloc/login_state.dart';
import 'package:flutterbloclogin/screens/auth/login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Navigator.of(context).pop();
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: Center(
          child: BlocBuilder<LoginBloc, LoginState> (
            builder: (context, state){
              if(state is InitialState) {
                return Center(child: Text('Initial'),);
              } else if(state is LoginLoadingState) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.blue,),
                );
              } else if(state is LoggedOutState) {
                return LoginScreen();
              } else {
                return Center(child: Text('error'),);
              }
            },
            
          )
        ),
      ),
    );
  }
}
