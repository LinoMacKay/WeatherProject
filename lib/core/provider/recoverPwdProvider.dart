import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RecoverPwdProvider {

  Future<dynamic> recoverPassword(dynamic email) async {
    final prefs = await SharedPreferences.getInstance();

    String url = 'https://uvbackend.azurewebsites.net/Auth/RequestPasswordChange';
    Uri uri = Uri.parse(url);

    var body = {
      'email': email
    };

    var response = await http.post(uri, body: json.encode(body),
      headers: {"Content-Type":"application/json"},);

    if (response.statusCode == 200) {
      dynamic jsonresponse = json.decode(response.body)['message'];
      print(response.body);
      return jsonresponse;
    } else {
      print(response.statusCode);
      return Future.error("Internal Server Error");
    }
  }



}