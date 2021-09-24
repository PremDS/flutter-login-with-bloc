
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppLoadEvent extends LoginEvent{}
class LoginButtonPressedEvent extends LoginEvent{
  final String email;
  final String password;
  LoginButtonPressedEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];

}
class LogoutButtonPressedEvent extends LoginEvent{}