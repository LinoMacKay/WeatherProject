import 'dart:convert';

class UviDto {
  double lat = 0.0;
  double long = 0.0;
  List<HourlyDto> hourly;

  UviDto(this.lat, this.long, this.hourly);

  factory UviDto.fromJson(Map<String, dynamic> uvijson) {
    var lat = uvijson['lat'];
    var long = uvijson['lon'];
    Iterable l = uvijson['hourly'];

    List<HourlyDto> hourly =
        List<HourlyDto>.from(l.map((model) => HourlyDto.fromJson(model)));

    return UviDto(lat, long, hourly);
  }

  Map<String, dynamic> toJson() => {'lat': lat, 'lon': long, 'hourly': hourly};
}

class HourlyDto {
  int dt;
  double temp;
  double feels_like;
  double uvi;

  HourlyDto(this.dt, this.feels_like, this.temp, this.uvi);

  HourlyDto.fromJson(Map<String, dynamic> json)
      : dt = json['dt'],
        temp = json['temp'] + 0.0,
        feels_like = json['feels_like'] + 0.0,
        uvi = json['uvi'] + 0.0;

  Map<String, dynamic> toJson() =>
      {'dt': dt, 'temp': temp, 'feels_like': feels_like, 'uvi': uvi};
}

class HomeInfoDto {
  HourlyDto horario;
  String highestUv;
  String considerUv;

  HomeInfoDto(
      {required this.horario,
      required this.considerUv,
      required this.highestUv});
}
