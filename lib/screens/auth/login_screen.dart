import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterbloclogin/screens/auth/register_page.dart';
import 'package:flutterbloclogin/screens/home_page.dart';
import 'package:flutterbloclogin/services/auth.dart';
import 'package:flutterbloclogin/utils/secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';
  bool isPasswordVisible = false;
  bool isLoggingIn = false;

  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LocalStorage.checkLogIn();
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(35),
        child: Form(
          key: _loginKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 150,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Bloc Login",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 45,
                ),
                _buildEmail(),
                const SizedBox(
                  height: 35,
                ),
                _buildPassword(),
                const SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                  onPressed: () {
                    print('here');
                    logIn(context);
                  },
                  child: isLoggingIn
                      ? const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 67, vertical: 6),
                          child: SizedBox(
                            // height: 35,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 65.0, vertical: 15),
                          child: Text('Login', style: TextStyle(fontSize: 16)),
                        ),
                  style: const ButtonStyle(
                      visualDensity: VisualDensity.comfortable),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have account ?'),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                      },
                      child: const Text(
                        'Register here',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
        labelText: 'Email Address',
        hintText: 'example@example.com',
        labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Email address is required';
        }
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please, enter a valid email address.';
        }
        return null;
      },
      onChanged: (value) {
        _email = value;
      },
      onSaved: (value) {
        _email = value ?? '';
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
        labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        prefixIcon: Icon(Icons.vpn_key),
        hintText: 'Your Password',
      ),
      obscureText: isPasswordVisible,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
      onSaved: (value) {
        _password = value!;
      },
      onChanged: (value) {
        _password = value;
      },
    );
  }

  logIn(BuildContext context) async {
    if (_loginKey.currentState!.validate()) {
      isLoggingIn = true;
      setState(() {});
      BaseAuthentication baseAuthentication = BaseAuthentication();
      final res = await baseAuthentication.loginUser(_email, _password);
      print(res);
      if (res['status'] == 'success') {
        try {
          LocalStorage.saveLoginCredentials(res['access_token']);
          await Future.delayed(const Duration(seconds: 1));
          isLoggingIn = false;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } catch (e) {
          isLoggingIn = false;
        }
      } else {
        isLoggingIn = false;
        print('not okay');
      }
    } else {
      print('invalid');
    }
  }
}
