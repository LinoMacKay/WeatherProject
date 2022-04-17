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
      //verificar si tienen la misma ubicacion
      if (num.parse(location.longitude.toStringAsFixed(2)) !=
              num.parse(uviInfo.long.toStringAsFixed(2)) &&
          num.parse(location.latitude.toStringAsFixed(2)) !=
              num.parse(uviInfo.lat.toStringAsFixed(2))) {
        uviInfo = await writeSharedPreference(location, prefs);
      }
      //verificar fechas
      final timestamp1 =
          uviInfo.hourly[uviInfo.hourly.length - 1].dt; // timestamp in seconds
      final DateTime date1 =
          DateTime.fromMillisecondsSinceEpoch(timestamp1 * 1000);
      var ahora = DateTime.now();
      var diff = ahora.difference(date1).inMinutes;
      if (diff >= 0) {
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

  Future<List<String>> getHomeData() async {
    final prefs = await SharedPreferences.getInstance();
    return [prefs.getString("userName")!, prefs.getString("userId")!];
  }
}
