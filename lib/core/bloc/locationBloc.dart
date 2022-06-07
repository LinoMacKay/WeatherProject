import 'dart:convert';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:my_project/core/provider/LocationProvider.dart';
import 'package:my_project/model/UviDto.dart';
import 'package:my_project/utils/NotificationService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationBloc {
  LocationProvider locationProvider = LocationProvider();

  Future<UviDto> getLocation(isRequested) async {
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
      var diff = date1.difference(ahora).inDays;
      if (diff <= 0) {
        uviInfo = await writeSharedPreference(location, prefs);
      }
      if (isRequested) {
        uviInfo = await writeSharedPreference(location, prefs);
      }
    }
    NotificationService().scheduleNotificationsForUvi();
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

  Future<UviDto> getUviInfoFromSP() async {
    final prefs = await SharedPreferences.getInstance();
    var uviInfo = UviDto(0.0, 0.0, []);

    var info = prefs.getString('uviInfo');
    Map<String, dynamic> jsonresponse = json.decode(info!);
    uviInfo = UviDto.fromJson(jsonresponse);
    return uviInfo;
  }

  HourlyDto getFechaMasCercana(
      UviDto info, Map<String, HourlyDto> horarios, List<num> diffdeHoras) {
    info.hourly.forEach((element) {
      final timestamp1 = element.dt; // timestamp in seconds
      final DateTime date1 =
          DateTime.fromMillisecondsSinceEpoch(timestamp1 * 1000);
      horarios[date1.toString()] = element;
    });
    //hallar la diferencia con la hora actual y pushear al arreglo de
    //diferencias de horas
    var ahoraSinMinutos = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, DateTime.now().hour);
    horarios.forEach((key, value) {
      var fecha = DateTime.tryParse(key);
      var diff = fecha!.difference(ahoraSinMinutos).inMinutes.abs();
      diffdeHoras.add(diff);
    });
    //hallar el menor y su indice
    var menordiff = diffdeHoras.reduce(min);
    var indx = diffdeHoras.indexWhere((element) => element == menordiff);
    var fechamasCercana = horarios[horarios.keys.toList()[indx]];
    //agregando la info de la fecha mas cercana
    return fechamasCercana!;
  }

  String uvMasAlto(homeInfoDto, horarios) {
    var menorUv = 0;
    List<dynamic> uvEnDia = [];

    uvEnDia = getUvEnDia(horarios);

    var mayor = 0.0;
    uvEnDia.forEach((element) {
      if (element[1] > mayor) mayor = element[1];
    });
    var mayorUvEnDia = uvEnDia.firstWhere((element) => element[1] == mayor);
    return DateFormat('hh:mm a', 'es_ES')
            .format(DateTime.tryParse(mayorUvEnDia[0])!) +
        " - " +
        DateFormat('hh:mm a', 'es_ES').format(
            DateTime.tryParse(mayorUvEnDia[0])!.add(Duration(hours: 1))) +
        " (${mayorUvEnDia[1].toString()})";
  }

  String uvAlto(List<dynamic> uvEnDia) {
    var uvAlto = uvEnDia.where((element) => element[1] >= 8).toList();
    if (uvAlto.length > 0) {
      return DateFormat('hh:mm a', 'es_ES')
              .format(DateTime.tryParse(uvAlto[0][0])!) +
          " - " +
          DateFormat('hh:mm a', 'es_ES').format(
              DateTime.tryParse(uvAlto[uvAlto.length - 1][0])!
                  .add(Duration(hours: 1)));
    } else {
      return "";
    }
  }

  List<dynamic> getUvEnDia(horarios) {
    List<dynamic> uvEnDia = [];
    horarios.forEach((key, value) {
      if (calculateDifference(DateTime.tryParse(key)!) == 0) {
        uvEnDia.add([key, value.uvi]);
      }
    });
    return uvEnDia;
  }

  List<dynamic> getUvEnDiaSiguiente(horarios) {
    List<dynamic> uvEnDia = [];
    horarios.forEach((key, value) {
      if (calculateDifference(DateTime.tryParse(key)!) == 1) {
        uvEnDia.add([key, value.uvi]);
      }
    });
    return uvEnDia;
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }
}
