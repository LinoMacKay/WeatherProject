import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:my_project/model/ChildDto.dart';
import 'package:my_project/model/CreateChildDto.dart';
import 'package:my_project/model/PhotoDto.dart';
import 'package:my_project/model/UpdateChildDto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChildProvider {
  Future<bool> createChild(CreateChildDto createChildDto) async {
    final prefs = await SharedPreferences.getInstance();

    String url = 'https://uvbackend.azurewebsites.net/Profile/CreateProfile';
    Uri uri = Uri.parse(url);

    var body = {
      'UserId': prefs.getString("userId"),
      'Profile': createChildDto.toJson()
    };

    var response = await http.post(uri,
        body: json.encode(body), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      dynamic jsonresponse = json.decode(response.body);
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

  Future<bool> updateChild(UpdateChildDto updateChildDto) async {
    final prefs = await SharedPreferences.getInstance();

    String url = 'https://uvbackend.azurewebsites.net/Profile/UpdateProfile';
    Uri uri = Uri.parse(url);

    var response = await http.patch(uri,
        body: json.encode(updateChildDto.toJson()),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      dynamic jsonresponse = json.decode(response.body);
      return true;
    } else {
      return Future.error("Internal Server Error");
    }
  }

  Future<ChildExtraInfoDto> getSingleChild(childId, uvi) async {
    final prefs = await SharedPreferences.getInstance();

    String url =
        'https://uvbackend.azurewebsites.net/Profile/GetExtraInfoByProfile?profileId=${childId}&input_uvi=${uvi}';
    Uri uri = Uri.parse(url);

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      dynamic jsonresponse = json.decode(response.body);

      var test = ChildExtraInfoDto.fromJson(jsonresponse);

      return test;
    } else {
      return Future.error("Internal Server Error");
    }
  }

  Future<bool> deleteChild(childId) async {
    final prefs = await SharedPreferences.getInstance();

    String url =
        'https://uvbackend.azurewebsites.net/Profile/DeleteProfile?profileId=${childId}';
    Uri uri = Uri.parse(url);

    var response =
        await http.delete(uri, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      //dynamic jsonresponse = json.decode(response.body);
      return true;
    } else {
      return Future.error("Internal Server Error");
    }
  }

  Future<PhotoDto> uploadPhoto(File image) async {
    final prefs = await SharedPreferences.getInstance();

    String url =
        'http://fitzpatrick.centralus.azurecontainer.io/api/v1/model/predict';
    Uri uri = Uri.parse(url);
    var formData = FormData.fromMap({
      if (image.path.isNotEmpty)
        "image": await MultipartFile.fromFile(image.path),
    });
    var resp = await Dio().post(
      url.toString(),
      data: formData,
    );
    print("resopnde code: " + resp.statusCode.toString());
    if (resp.statusCode == 200) {
      var data = resp.data as Map<String, dynamic>;

      return PhotoDto.fromJson(data);
    } else {
      return Future.error("Internal Server Error");
    }
  }
}
