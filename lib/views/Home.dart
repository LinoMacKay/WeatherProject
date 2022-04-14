import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/core/bloc/locationBloc.dart';
import 'package:my_project/core/provider/locationProvider.dart';
import 'package:my_project/core/ui/labeled_text_component.dart';
import 'package:my_project/model/UviDto.dart';
import 'package:my_project/router/routes.dart';
import 'package:my_project/utils/Utils.dart';
import 'package:my_project/views/user/location/components/no_children_component.dart';
import 'package:my_project/views/user/uv/user_uv_summary.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late LocationBloc locationBloc;
  HomeInfoDto homeInfoDto = HomeInfoDto(
      horario: HourlyDto(0, 0, 0, 0), considerUv: "", highestUv: "");
  @override
  void initState() {
    locationBloc = LocationBloc();
    super.initState();
  }

  HomeInfoDto getData(UviDto info) {
    Map<String, HourlyDto> horarios = {};
    List<num> diffdeHoras = [];
    //Convertir las fechas de timestamp a datetime
    //guardarlos en el mapa de horarios con la fecha como key
    info.hourly.forEach((element) {
      final timestamp1 = element.dt; // timestamp in seconds
      final DateTime date1 =
          DateTime.fromMillisecondsSinceEpoch(timestamp1 * 1000);
      horarios[date1.toString()] = element;
    });
    //hallar la diferencia con la hora actual y pushear al arreglo de
    //diferencias de horas
    var ahora = DateTime.now();
    horarios.forEach((key, value) {
      var fecha = DateTime.tryParse(key);
      var diff = fecha!.difference(ahora).inMinutes;
      diffdeHoras.add(diff);
    });
    //hallar el menor y su indice
    var menordiff = diffdeHoras.reduce(min);
    var indx = diffdeHoras.indexWhere((element) => element == menordiff);
    var fechamasCercana = horarios[horarios.keys.toList()[indx]];
    //agregando la info de la fecha mas cercana
    homeInfoDto.horario = fechamasCercana!;
    homeInfoDto.considerUv = "ga";
    homeInfoDto.highestUv = "aea";
    //UV MAS ALTO
    var menorUv = 0;
    List<dynamic> uvEnDia = [];

    horarios.forEach((key, value) {
      if (calculateDifference(DateTime.tryParse(key)!) == 0) {
        uvEnDia.add([key, value.uvi]);
      }
    });
    var mayor = 0.0;

    uvEnDia.forEach((element) {
      if (element[1] > mayor) mayor = element[1];
    });
    var mayorUvEnDia = uvEnDia.firstWhere((element) => element[1] == mayor);
    homeInfoDto.highestUv = DateFormat('hh:mm a', 'es_ES')
            .format(DateTime.tryParse(mayorUvEnDia[0])!) +
        " - " +
        DateFormat('hh:mm a', 'es_ES').format(
            DateTime.tryParse(mayorUvEnDia[0])!.add(Duration(hours: 1))!);
    return homeInfoDto;
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  Widget UviInfo(screenWidth) {
    return Container(
      child: FutureBuilder(
          future: locationBloc.getLocation(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              var info = snapshot.data as UviDto;
              var nowInfo = getData(info) as HomeInfoDto;
              return Column(
                children: [
                  Text("Data"),
                  LabeledTextComponent(
                      label: 'Highest uv of the day:', text: nowInfo.highestUv),
                  LabeledTextComponent(
                      label: 'Range of hours with UVI considered high:',
                      text: nowInfo.considerUv),
                  LabeledTextComponent(
                      label: 'Temperature:',
                      text: nowInfo.horario.temp.toString() + "°"),
                  LabeledTextComponent(
                      label: 'UV:', text: nowInfo.horario.uvi.toString()),
                  LabeledTextComponent(
                      label: 'Hour:',
                      text:
                          DateFormat('hh:mm a', 'es_ES').format(DateTime.now()))
                ],
              );
            } else {
              return Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(10),
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      "Bienvenido User01, Tenga un buen día",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Flexible(
                    flex: 2,
                    child: NoChildrenComponent(
                      appName: "Appname",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return Dialog(
                                insetPadding: EdgeInsets.all(10),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: screenWidth,
                                  height: screenHeight * 0.3,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(
                                          "¿Qué es el UVI?",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Row(
                        children: [
                          Text(
                            "¿Qué es el UVI?",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.help,
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 10),
                      child: UviInfo(screenWidth))
                ],
              ),
              Positioned(
                bottom: 0,
                child: Ink(
                  height: 50,
                  width: 50,
                  decoration: ShapeDecoration(
                    color: Colors.red,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () {
                      Utils.homeNavigator.currentState!
                          .pushNamed(routeChildrenCreateView);
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }
}
