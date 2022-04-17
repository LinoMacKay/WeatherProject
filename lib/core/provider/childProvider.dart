import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_project/model/ChildDto.dart';
import 'package:my_project/model/CreateChildDto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChildProvider {
  Future<bool> createChild(CreateChildDto createChildDto) async {
    final prefs = await SharedPreferences.getInstance();

    String url = 'https://uvbackend.azurewebsites.net/Profile/CreateProfile';
    Uri uri = Uri.parse(url);

    var body = {
      // 'UserId': prefs.getString("token"),
      'Profile': createChildDto.toJson()
    };

    var response = await http.post(uri, body: json.encode(body));

    if (response.statusCode == 200) {
      List<dynamic> jsonresponse = json.decode(response.body);
      return true;
    } else {
      return Future.error("Internal Server Error");
    }
  }

  Future<List<ChildDto>> getAllChildsFromFather(userId) async {
    final prefs = await SharedPreferences.getInstance();

    String url =
        'https://uvbackend.azurewebsites.net/Profile/GetProfilesByUSer?userId=${userId}';
    Uri uri = Uri.parse(url);

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      dynamic jsonresponse = json.decode(response.body)['data'] as List;
      List<ChildDto> childs = [];
      jsonresponse.forEach((element) {
        var test = ChildDto.fromJson(element);
        childs.add(test);
      });

      return childs;
    } else {
      return Future.error("Internal Server Error");
    }
  }
}
