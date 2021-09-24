import 'package:equatable/equatable.dart';
import 'package:flutterbloclogin/bloc/login_event.dart';
import 'package:flutterbloclogin/model/user_profile.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends LoginState {}

class LoginLoadingState extends LoginState{}

class LoggedInState extends LoginState{
  final UserProfile userProfile;
  LoggedInState({required this.userProfile});


  @override
  List<Object> get props => [userProfile];
}

class LoginFailedState extends LoginState{
  final String error;
  LoginFailedState({required this.error});

  @override
  List<Object> get props => [error];
}

class LoggedOutState extends LoginState{}
