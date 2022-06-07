import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:my_project/model/UviDto.dart';

class LocationProvider {
  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<UviDto> getUviInfo(lat, long) async {
    String url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=${lat}&lon=${long}&appid=2a038b818679ee75210451bb74775bbb&units=metric';
    Uri uri = Uri.parse(url);

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonresponse = json.decode(response.body);
      return UviDto.fromJson(jsonresponse);
      ;
    } else {
      return Future.error("Internal Server Error");
    }
  }
}
