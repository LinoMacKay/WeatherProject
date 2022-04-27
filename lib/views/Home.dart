import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/core/bloc/childBloc.dart';
import 'package:my_project/core/bloc/locationBloc.dart';
import 'package:my_project/core/provider/locationProvider.dart';
import 'package:my_project/core/ui/labeled_text_component.dart';
import 'package:my_project/model/UviDto.dart';
import 'package:my_project/router/routes.dart';
import 'package:my_project/utils/NotificationService.dart';
import 'package:my_project/utils/Utils.dart';
import 'package:my_project/views/user/location/components/no_children_component.dart';
import 'package:my_project/views/user/uv/user_uv_summary.dart';

import '../helper/constants/recomendaciones.dart';

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

  RecomendacionesDiarias listRecomendaciones = RecomendacionesDiarias();
  var recomendacionDiaria = "";
  var diaActual = 0;


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

    NotificationService().scheduleNotificationsForUvi();
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
                      label: 'UV más alto del día:', text: nowInfo.highestUv),
                  if (homeInfoDto.considerUv.length > 1)
                    LabeledTextComponent(
                        label: 'Rango de horas con UVI considerado alto:',
                        text: nowInfo.considerUv),
                  LabeledTextComponent(
                      label: 'Temperatura:',
                      text: nowInfo.horario.temp.toString() + "°"),
                  LabeledTextComponent(
                      label: 'UVI:', text: nowInfo.horario.uvi.toString()),
                  LabeledTextComponent(
                      label: 'Hora:',
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

  Widget UviRangeBoard() {
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
              ["Baja", "0-2", "No hay peligro para la persona promedio."],
              colorRow: Colors.green,
            ),
            _tableRow(
              [
                "Moderada",
                "3-5",
                "Poco riesgo de daño por la exposición al sol sin protección"
              ],
              colorRow: Colors.yellowAccent,
            ),
            _tableRow(
              [
                "Alta",
                "6-7",
                "Alto riesgo de daño por la exposición al sol sin protección"
              ],
              colorRow: Colors.orangeAccent,
            ),
            _tableRow(
              [
                "Muy Alta",
                "8-10",
                "Muy alto riesgo de daño por la exposición al sol sin protección"
              ],
              colorRow: Colors.red,
            ),
            _tableRow(
              [
                "Extremadamente Alta",
                "11+",
                "Riesgo extremo de daño por la exposición al sol sin protección"
              ],
              colorRow: Colors.deepPurpleAccent,
            ),
          ],
        )
      ],
    );
  }

  Widget MitoUVBoard() {
    var heigtCell = 100.0;
    return Column(
      children: [
        Table(
          border: TableBorder.all(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {2: FixedColumnWidth(120.0)},
          children: [
            _tableRow(
              ["Mito", "Verdad"],
              isHeader: true,
              colorRow: Colors.red,
              colorRowOptional: Colors.green,
            ),
            _tableRow([
              "No puedes quemarte con el sol en un día nublado",
              "Hasta el 80% de la radiación UV solar puede penetrar la capa de nubes ligeras. La neblina en la atmósfera puede incluso aumentar la exposición a la radiación UV."
            ],
                colorRow: Colors.red.shade300,
                colorRowOptional: Colors.green.shade300,
                heighContainer: heigtCell),
            _tableRow([
              "No puedes quemarte con el sol mientras estás en el agua",
              "El agua ofrece solo una protección mínima contra la radiación ultravioleta, y los reflejos del agua pueden aumentar la exposición a la radiación ultravioleta."
            ],
                colorRow: Colors.red.shade300,
                colorRowOptional: Colors.green.shade300,
                heighContainer: heigtCell),
            _tableRow([
              "La Radiación UV durante el invierno, no es peligrosa",
              "La radiación ultravioleta es generalmente más baja durante los meses de invierno, pero el reflejo de la nieve puede duplicar su exposición general, especialmente a gran altura. Preste especial atención a principios de la primavera cuando las temperaturas son bajas pero los rayos del sol son inesperadamente fuertes."
            ],
                colorRow: Colors.red.shade300,
                colorRowOptional: Colors.green.shade300,
                heighContainer: heigtCell),
            _tableRow([
              "Si no sientes los rayos calientes del sol, no te quemarás.",
              "Las quemaduras solares son causadas por la radiación UV, la cual que no se puede sentir. El efecto de calor es causado por la radiación infrarroja del sol y no por la radiación UV."
            ],
                colorRow: Colors.red.shade300,
                colorRowOptional: Colors.green.shade300,
                heighContainer: heigtCell+30.0),
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
                          "¿Qué significa el FPS en las cremas solares?",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          color: Colors.blue,
                          height: 3,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                            "Abreviado de Factor de Protección Solar, es un factor que multiplica el tiempo que puede permanecer una persona, con un tipo de piel determinado, expuesta al sol. Por ejemplo, una persona con piel de Tipo I, de acuerdo con la escala de Fitzpatrick, puede exponerse 10 minutos sin quemarse. Al aplicar una crema de protección solar con un FPS de 30, multiplica ese valor por 30, es decir podrá permanecer 300 minutos sin presentar consecuencias por el sol (National Geographic, 2019)."),
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
            "FPS en cremas solares",
            overflow: TextOverflow.ellipsis,
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
                          "Mitos de la radiación UV",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          color: Colors.blue,
                          height: 3,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        MitoUVBoard(),
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
            "Mitos de la radiación UV",
            overflow: TextOverflow.ellipsis,
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

  Widget Recomendacion(screenWidth, screenHeight) {
    return GestureDetector(
      onTap: () {
        if(recomendacionDiaria == "" && diaActual == 0){ //agregando valores inciales a recomendacion diaria y fecha actual
          var recomRandom =
          Random().nextInt(listRecomendaciones.recomendaciones.length);
          setState(() {
            recomendacionDiaria = listRecomendaciones.recomendaciones[recomRandom];
            diaActual = DateTime.now().day;
          });
        }

        if(recomendacionDiaria != "" && diaActual != DateTime.now().day){   // actualizando recomendacion si es otro dia
            var recomRandom =
            Random().nextInt(listRecomendaciones.recomendaciones.length);
            var nuevaRecomendacion = listRecomendaciones.recomendaciones[recomRandom];

            while(recomendacionDiaria == nuevaRecomendacion){     // actualziando recomendacion si la nueva recomend. random es la misma
              recomRandom = Random().nextInt(listRecomendaciones.recomendaciones.length);
              nuevaRecomendacion = listRecomendaciones.recomendaciones[recomRandom];
            }
            setState(() {
              recomendacionDiaria = nuevaRecomendacion;
              diaActual = DateTime.now().day;
            });
        }
        print(recomendacionDiaria);
        print(diaActual.toString());
        showDialog(
            context: context,
            builder: (ctx) {

              return Dialog(
                insetPadding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: screenWidth,
                  //height: screenHeight * 0.6,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "Recomendación del día",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(recomendacionDiaria),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      child: Text(
        'Recomendación del día',
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  TableRow _tableRow(List<dynamic> cells,
      {bool isHeader = false,
      Color colorRow = Colors.white,
      Color colorRowOptional = Colors.white,
      Color colorText = Colors.black,
      double heighContainer = 80}) {
    return TableRow(
        children: cells.map((cell) {
      final style = TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 14 : 11,
          color: colorText);
      if (cell == cells[1] &&
          cell == cell.toString() &&
          colorRowOptional != Colors.white) {
        return Container(
          height: heighContainer,
          color: colorRowOptional,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: isHeader ? Alignment.center : Alignment.centerLeft,
              child: Text(
                cell,
                style: style,
              ),
            ),
          ),
        );
      } else if (cell == cell.toString()) {
        return Container(
          height: heighContainer,
          color: colorRow,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: isHeader ? Alignment.center : Alignment.centerLeft,
              child: Text(
                cell,
                style: style,
              ),
            ),
          ),
        );
      } else {
        return Container(
          height: heighContainer,
          color: cell,
          child: Padding(
            padding: const EdgeInsets.all(12),
          ),
        );
      }
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
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Recomendacion(screenWidth, screenHeight)),
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
                                              color: Colors.blue),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          color: Colors.blue,
                                          height: 3,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                            "Proviene del término en inglés UV Index o Índice de radiación Ultravioleta en español, es la métrica de radiación UV en la superficie terrestre, así como un indicador de las posibles lesiones en la piel como consecuencia a la exposición a dicha radiación. Asimismo, depende de diversos factores como la altura del sol, la latitud, la altitud, la nubosidad, el nivel de ozono y la reflexión por el suelo (OMS, 2002). En la siguiente tabla se muestra la escala de este:"),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        UviRangeBoard(),
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
                  Container(
                    width: screenWidth * 0.9,
                    child: Wrap(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Pregunta2(screenWidth, screenHeight),
                        Pregunta3(screenWidth, screenHeight)
                      ],
                    ),
                  ),
                  /* ElevatedButton(
                      onPressed: () {
                        NotificationService()
                            .checkPendingNotificationRequests(context);
                      },
                      child: Text("CheckPending")),
                   ElevatedButton(
                      onPressed: () {
                        NotificationService().scheduleNotificationsForUvi();
                      },
                      child: Text("ProbarNotificaciones")),
                  ElevatedButton(
                      onPressed: () {
                        NotificationService().cancelAllNotifications();
                      },
                      child: Text("Cancel"))*/
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
