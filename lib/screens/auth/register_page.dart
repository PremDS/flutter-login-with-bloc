import 'package:flutter/material.dart';
import 'package:flutterbloclogin/screens/auth/login_page.dart';
import 'package:flutterbloclogin/screens/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email = '';
  String _password = '';
  String _name = '';
  bool isPasswordVisible = false;
  bool isRegistering = false;
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(35),
        child: Form(
          key: _registerKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 130,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 35,
                ),
                _buildName(),
                const SizedBox(
                  height: 30,
                ),
                _buildEmail(),
                const SizedBox(
                  height: 30,
                ),
                _buildPassword(),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    registerAccount(context);
                    isRegistering = true;
                  },
                  child: isRegistering
                      ? SizedBox(height: 35,child: CircularProgressIndicator(color:Colors.white),)
                      : const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 65.0, vertical: 15),
                          child:
                              Text('Register', style: TextStyle(fontSize: 16)),
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
                    const Text('Already have account?'),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text(
                        'Login here',
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

  Widget _buildName() {
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Full Name',
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        prefixIcon: Icon(Icons.person),
        hintText: 'Full Name...',
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Full Name is required.';
        }
        if (value.length < 5) {
          return 'Name should be more than 5 letters.';
        }
        if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
          return 'Digits and special characters not allowed.';
        }

        return null;
      },
      onChanged: (value) {
        _name = value;
      },
      onSaved: (value) {
        _name = value!;
      },
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
        if (value.length < 6) {
          return 'Password length should be more than 6 letters.';
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

  registerAccount(BuildContext context) async {
    if(_registerKey.currentState!.validate()) {
      isRegistering = true;
      setState(() {});
      await Future.delayed(const Duration(seconds: 2));
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));


    }
  }
}
