import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloclogin/bloc/login_event.dart';
import 'package:flutterbloclogin/bloc/login_state.dart';
import 'package:flutterbloclogin/model/user_profile.dart';
import 'package:flutterbloclogin/services/auth.dart';
import 'package:flutterbloclogin/utils/secure_storage.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  BaseAuthentication baseAuthentication = BaseAuthentication();
  LoginBloc() : super(InitialState());

  @override
  LoginState get initialState => InitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AppLoadEvent) {
      print('Appload event');
      yield LoginLoadingState();
      bool isUserLoggedIn = await LocalStorage.checkLogIn();
      try {
        if (isUserLoggedIn) {
          UserProfile userProfile = await baseAuthentication.getUserProfile();
          if (userProfile.status == 'success') {
            await Future.delayed(const Duration(seconds: 1));
            yield LoggedInState(userProfile: userProfile);
          } else {
            yield LoginFailedState(error: "${userProfile.message}");
            await Future.delayed(Duration(seconds: 1));
            yield LoggedOutState();
          }
        }
      } catch (e) {
        yield LoginFailedState(
            error: 'Unable to connect: Check your internet connection!');
      }
    }

    if (event is LoginButtonPressedEvent) {
      try {
        yield LoginLoadingState();
        var res =
            await baseAuthentication.loginUser(event.email, event.password);
        if (res['status'] == 'success') {
          LocalStorage.saveLoginCredentials(res['access-token']);
          UserProfile? userData = await baseAuthentication.getUserProfile();
          yield LoggedInState(userProfile: userData!);
        } else {
          yield LoginFailedState(error: res['message']);
          await Future.delayed(const Duration(seconds: 1));
          yield LoggedOutState();
        }
      } catch (e) {
        yield LoginFailedState(error: 'Unable to login');
      }
    }

    if (event is LogoutButtonPressedEvent) {
      try {
        final res = await baseAuthentication.logoutUser();
        if (res['status'] == 'success') {
          LocalStorage.deleteLoginCrendentails();
          await Future.delayed(const Duration(seconds: 2));
          yield LoggedOutState();
        } else {
          yield LoginFailedState(error: res['message']);
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
