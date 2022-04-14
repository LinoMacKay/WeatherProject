import 'dart:convert';

import 'package:my_project/core/provider/LocationProvider.dart';
import 'package:my_project/model/UviDto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationBloc {
  LocationProvider locationProvider = LocationProvider();

  Future<UviDto> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    var uviInfo = UviDto(0.0, 0.0, []);

    var location = await locationProvider.getPosition();

    if (prefs.getDouble("lat") == null || prefs.getDouble('lon') == null) {
      //Guardar por primera vez
      uviInfo = await writeSharedPreference(location, prefs);
    } else {
      //obtener el guardado
      var info = prefs.getString('uviInfo');
      Map<String, dynamic> jsonresponse = json.decode(info!);
      uviInfo = UviDto.fromJson(jsonresponse);
      if (location.longitude == uviInfo.long &&
          location.latitude == uviInfo.lat) {
        return uviInfo;
      } else {
        uviInfo = await writeSharedPreference(location, prefs);
      }
    }

    return uviInfo;
  }

  Future<UviDto> writeSharedPreference(location, prefs) async {
    await prefs.setDouble("lat", location.latitude);
    await prefs.setDouble("lon", location.longitude);
    var uviInfo = await locationProvider.getUviInfo(
        location.latitude, location.longitude);
    await prefs.setString('uviInfo', json.encode(uviInfo));
    return uviInfo;
  }
}
