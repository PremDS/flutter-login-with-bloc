import 'package:flutterbloclogin/model/user_profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
class BaseAuthentication {
  
  //login User function
  Future loginUser(email, password) async {
    const String loginBaseURL = 'https://api.ikreate.com.np/intern/login';
    const headers = <String, String>  {
      'Content-Type':'application/x-www-form-urlencoded',
      'primary-auth':'api.ikreate.com.np'
    };
    final body = {
      'email-address':email,
      'password': password
    };

    var decodedResponse;

    try {
      final res = await http.post(Uri.parse(loginBaseURL), headers: headers,body: body);

      if (res.statusCode == 200 ) {
        decodedResponse = json.decode(res.body);
        return decodedResponse;
      }

    } catch(e,t){
      print('Exceptioon:'+e.toString());
      print('Trackback: '+t.toString());
    }
  }


  // Lougt user function
  Future logoutUser() async {
    
    final String? accessToken = await secureStorage.read(key:'access-token');
    final String? refreshToken = await secureStorage.read(key:'refresh-token');
    const String logoutBaseURL = 'https://api.ikreate.com.np/intern/logout';
    var decodedResponse;

    try {
      final headers = <String, String>  {
      'Content-Type':'application/x-www-form-urlencoded',
      'primary-auth':'api.ikreate.com.np',
      'access-token':accessToken!,
      'refresh-token':refreshToken!
    };
      final res = await http.post(Uri.parse(logoutBaseURL), headers: headers);
      
      if(res.statusCode == 200) {
        decodedResponse  = json.decode(res.body);
        return decodedResponse;

      }
    } catch(e, t) {
      print(e);
      print(t);
    }

    
  }

  // get user profile detail
  Future getUserProfile() async {
    final String? accessToken = await secureStorage.read(key:'access-token');
    final String? refreshToken = await secureStorage.read(key:'refresh-token');
    const String profileBaseURL = "https://api.ikreate.com.np/intern/profile";
    var decodedResponse;

    try {
      final headers = <String, String> {
        'Content-Type': 'application/x-www-form-urlencoded',
        'primary-auth': 'api.ikreate.com.np',
        'access-token': accessToken!,
        'refresh-token': refreshToken!
      };
      final res = await http.get(Uri.parse(profileBaseURL),headers: headers);
      if (res.statusCode == 200) {
        decodedResponse = UserProfile.fromJson(json.decode(res.body));
        print("Response: ${decodedResponse.runtimeType}");
      } 
    } catch(e,t) {
      print(e);
      print(t);
    }

  } 



}