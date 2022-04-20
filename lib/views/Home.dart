import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/core/bloc/childBloc.dart';
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
  ChildBloc childBloc = ChildBloc();
  var futureLocation;
  HomeInfoDto homeInfoDto = HomeInfoDto(
      horario: HourlyDto(0, 0, 0, 0), considerUv: "", highestUv: "");

  String userName = " ";
  @override
  void initState() {
    locationBloc = LocationBloc();
    futureLocation = locationBloc.getLocation();
    locationBloc.getHomeData().then((value) {
      setState(() {
        userName = value[0];
      });
    });
    super.initState();
  }

  HomeInfoDto getData(UviDto info) {
    Map<String, HourlyDto> horarios = {};
    List<num> diffdeHoras = [];

    homeInfoDto.horario =
        locationBloc.getFechaMasCercana(info, horarios, diffdeHoras);
    homeInfoDto.highestUv = locationBloc.uvMasAlto(homeInfoDto, horarios);
    homeInfoDto.considerUv =
        locationBloc.uvAlto(locationBloc.getUvEnDia(horarios));
    return homeInfoDto;
  }

  Widget UviInfo(screenWidth) {
    return Container(
      child: FutureBuilder(
          future: futureLocation,
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              var info = snapshot.data as UviDto;
              var nowInfo = getData(info) as HomeInfoDto;
              return Column(
                children: [
                  LabeledTextComponent(
                      label: 'Highest uv of the day:', text: nowInfo.highestUv),
                  if (homeInfoDto.considerUv.length > 1)
                    LabeledTextComponent(
                        label: 'Range of hours with UVI considered high:',
                        text: nowInfo.considerUv),
                  LabeledTextComponent(
                      label: 'Temperature:',
                      text: nowInfo.horario.temp.toString() + "°"),
                  LabeledTextComponent(
                      label: 'UVI:', text: nowInfo.horario.uvi.toString()),
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

  Widget PopUpUviInfoBoard() {
    return Column(
      children: [
        Table(
          border: TableBorder.all(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {2: FixedColumnWidth(120.0)},
          children: [
            _tableRow(["Categoría", "Rango de UVI", "Descripción"],
                isHeader: true),
            _tableRow(
                ["Baja", "0-2", "No hay peligro para la persona promedio."]),
            _tableRow([
              "Moderada",
              "3-5",
              "Poco riesgo de daño por la exposición al sol sin protección"
            ]),
            _tableRow([
              "Alta",
              "6-7",
              "Alto riesgo de daño por la exposición al sol sin protección"
            ]),
            _tableRow([
              "Muy Alta",
              "8-10",
              "Muy alto riesgo de daño por la exposición al sol sin protección"
            ]),
            _tableRow([
              "Extremadamente Alta",
              "11+",
              "Riesgo extremo de daño por la exposición al sol sin protección"
            ]),
          ],
        )
      ],
    );
  }

  Widget Pregunta2(screenWidth, screenHeight) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (ctx) {
              return Dialog(
                insetPadding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: screenWidth,
                  height: screenHeight * 0.5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "¿Qué es el UVI?",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                            "Proviene del término en inglés UV Index o Índice de radiación Ultravioleta en español, es la métrica de radiación UV en la superficie terrestre, así como un indicador de las posibles lesiones en la piel como consecuencia a la exposición a dicha radiación. Asimismo, depende de diversos factores como la altura del sol, la latitud, la altitud, la nubosidad, el nivel de ozono y la reflexión por el suelo (OMS, 2002). En la siguiente tabla se muestra la escala de este:"),
                        SizedBox(
                          height: 30,
                        ),
                        PopUpUviInfoBoard(),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Fototipo de Piel",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                            "El fototipo es la capacidad de adaptación al sol que tiene cada persona desde que nace, es decir, el conjunto de características que determinan si una piel se broncea o no, y cómo y en qué grado lo hace. Cuanto más baja sea esta capacidad, menos se contrarrestarán los efectos de las radiaciones solares en la piel (Marín & Del Pozo, 2005). La clasificación más famosa de los fototipos cutáneos es la del Dr. Thomas Fitzpatrick, mostrada en la siguiente tabla:"),
                        SizedBox(
                          height: 30,
                        ),
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
            "¿PREGUNTA 2?",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
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
    );
  }

  Widget Pregunta3(screenWidth, screenHeight) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (ctx) {
              return Dialog(
                insetPadding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: screenWidth,
                  height: screenHeight * 0.5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "¿Qué es el UVI?",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                            "Proviene del término en inglés UV Index o Índice de radiación Ultravioleta en español, es la métrica de radiación UV en la superficie terrestre, así como un indicador de las posibles lesiones en la piel como consecuencia a la exposición a dicha radiación. Asimismo, depende de diversos factores como la altura del sol, la latitud, la altitud, la nubosidad, el nivel de ozono y la reflexión por el suelo (OMS, 2002). En la siguiente tabla se muestra la escala de este:"),
                        SizedBox(
                          height: 30,
                        ),
                        PopUpUviInfoBoard(),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Fototipo de Piel",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                            "El fototipo es la capacidad de adaptación al sol que tiene cada persona desde que nace, es decir, el conjunto de características que determinan si una piel se broncea o no, y cómo y en qué grado lo hace. Cuanto más baja sea esta capacidad, menos se contrarrestarán los efectos de las radiaciones solares en la piel (Marín & Del Pozo, 2005). La clasificación más famosa de los fototipos cutáneos es la del Dr. Thomas Fitzpatrick, mostrada en la siguiente tabla:"),
                        SizedBox(
                          height: 30,
                        ),
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
            "¿PREGUNTA 3?",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
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
    );
  }

  TableRow _tableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
        children: cells.map((cell) {
      final style = TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 14 : 11);
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          cell,
          style: style,
        ),
      );
    }).toList());
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
                      "Bienvenido ${userName}",
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
                                  height: screenHeight * 0.5,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(
                                          "¿Qué es el UVI?",
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                            "Proviene del término en inglés UV Index o Índice de radiación Ultravioleta en español, es la métrica de radiación UV en la superficie terrestre, así como un indicador de las posibles lesiones en la piel como consecuencia a la exposición a dicha radiación. Asimismo, depende de diversos factores como la altura del sol, la latitud, la altitud, la nubosidad, el nivel de ozono y la reflexión por el suelo (OMS, 2002). En la siguiente tabla se muestra la escala de este:"),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        PopUpUviInfoBoard(),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Text(
                                          "Fototipo de Piel",
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                            "El fototipo es la capacidad de adaptación al sol que tiene cada persona desde que nace, es decir, el conjunto de características que determinan si una piel se broncea o no, y cómo y en qué grado lo hace. Cuanto más baja sea esta capacidad, menos se contrarrestarán los efectos de las radiaciones solares en la piel (Marín & Del Pozo, 2005). La clasificación más famosa de los fototipos cutáneos es la del Dr. Thomas Fitzpatrick, mostrada en la siguiente tabla:"),
                                        SizedBox(
                                          height: 30,
                                        ),
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
                      child: UviInfo(screenWidth)),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Pregunta2(screenWidth, screenHeight),
                      Pregunta3(screenWidth, screenHeight)
                    ],
                  ),
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
