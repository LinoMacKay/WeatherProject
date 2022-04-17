import 'dart:async';
import 'dart:convert';

import 'package:my_project/model/LoginDto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/RegisterDto.dart';

class UserProvider {
  Future<bool> login(LoginDto loginDto) async {
    String url = 'https://uvbackend.azurewebsites.net/Auth/Login';
    Uri uri = Uri.parse(url);

    var body = {"UserName": loginDto.user, "Password": loginDto.password};

    var response = await http.post(uri, body: json.encode(body), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });

    if (response.statusCode == 200) {
      dynamic jsonresponse = json.decode(response.body);
      await saveLogin(jsonresponse);
      return true;
    } else {
      return Future.error("Internal Server Error");
    }
  }

  Future<void> saveLogin(jsonresponse) async {
    final prefs = await SharedPreferences.getInstance();
    var data = jsonresponse['data'];
    prefs.setString("userName", data['userName']);
    prefs.setString("userId", data['userId']);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userName");
    prefs.remove("userId");
  }

  Future<bool> register(RegisterDto registerDto) async {
    String url = 'https://uvbackend.azurewebsites.net/Auth/Register';
    Uri uri = Uri.parse(url);

    var body = {"UserName": registerDto.user, "Password": registerDto.password,"Email": registerDto.email};

    var response = await http.post(uri, body: json.encode(body), headers: {
      "Content-Type": "application/json"
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return Future.error("Internal Server Error");
    }
  }
}
