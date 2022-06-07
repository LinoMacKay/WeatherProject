import 'dart:convert';
import 'dart:math';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/core/bloc/childBloc.dart';
import 'package:my_project/core/bloc/locationBloc.dart';
import 'package:my_project/core/bloc/loginBloc.dart';
import 'package:my_project/core/provider/childProvider.dart';
import 'package:my_project/core/ui/profile_component.dart';
import 'package:my_project/core/ui/user_fototipo_component.dart';
import 'package:my_project/data/viewmodels/fototipo_option.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/model/ChildDto.dart';
import 'package:my_project/model/UviDto.dart';
import 'package:my_project/utils/Utils.dart';
import 'package:my_project/views/tabs/ProfilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/bloc/createChildBloc.dart';
import '../../../router/routes.dart';
import '../../../utils/NotificationHelper.dart';

import '../../../router/routes.dart';
import '../update/children_update_view.dart';

class ChildrenSummaryView extends StatefulWidget {
  const ChildrenSummaryView({Key? key}) : super(key: key);

  @override
  State<ChildrenSummaryView> createState() => _ChildrenSummaryViewState();
}

class _ChildrenSummaryViewState extends State<ChildrenSummaryView> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Utils.homeNavigator.currentState!.pop();
    return true;
  }

  Future<List<dynamic>> getData(childId) async {
    var uviInfo = await LocationBloc().getUviInfoFromSP();
    var uvMainInfo = LocationBloc().getFechaMasCercana(uviInfo, {}, []);
    print(uvMainInfo);
    var childExtraInfo =
        await ChildProvider().getSingleChild(childId, uvMainInfo.uvi);

    return [childExtraInfo, uvMainInfo];
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  List<TableRow> getRecommendation(
      uvi, ChildExtraInfoDto childInfo, screenWidth, screenHeight) {
    var recommendation1 = "";
    var recommendation2 = "";

    var fps = childInfo.fps;
    if (fps == "50") {
      fps = "50+";
    } else if (fps == "15") {
      fps = "al menos 15";
    }

    if (uvi <= 2) {
      recommendation1 = "¡Puedes quedarte afuera con total seguridad!";
      recommendation2 = "¡No necesitas protector solar!";
    } else if (uvi <= 7) {
      recommendation1 = "¡Busca la sombra!";
      recommendation2 =
          "¡Ponte una camisa o polo o blusa, junto a un protector solar de al menos ${fps} fps y un sombrero!";
    } else {
      recommendation1 = "¡Evita estar afuera!";
      recommendation2 = "¡Asegurate de buscar sombra!\n" +
          "¡Una camisa o polo o blusa, , junto a un protector solar de al menos ${fps} fps y sombrero no deben faltar!";
    }

    var exposureTime = childInfo.exposureTime;
    var horas = exposureTime!.toInt();
    var minutos =
        (double.tryParse((exposureTime - horas).toStringAsFixed(2))! * 60)
            .toInt();

    var timeToShow = "";
    if (horas == 0) {
      timeToShow = "${minutos} minutos";
    } else {
      timeToShow = horas == 1
          ? "${horas} hora y ${minutos} minutos"
          : "${horas} horas y ${minutos} minutos";
    }
    return [
      if (exposureTime > 0)
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (uvi > 2) Text("Posible quemadura solar en ${timeToShow}"),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (builder) {
                          return Dialog(
                            insetPadding: EdgeInsets.all(10),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: screenWidth,
                              height: screenHeight * 0.15,
                              child: Center(
                                  child: Text(
                                "*La quemadura solar es una clara señal de sobredosis de rayos UV. No es recomendable tomar ese tiempo como un período exposición segura.",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              )),
                            ),
                          );
                        });
                  },
                  child: Icon(
                    Icons.info,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        ]),
      TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(recommendation1),
        ),
      ]),
      TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(recommendation2),
        ),
      ])
    ];
  }

  Widget recomendaciones(childId, screenWidth, screenHeight) {
    return FutureBuilder(
        future: getData(childId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data as List;
            var childExtraInfo = data[0] as ChildExtraInfoDto;
            var uviInfo = data[1] as HourlyDto;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                children: <Widget>[
                  Table(
                      border: TableBorder.symmetric(
                        inside: BorderSide(width: 1),
                      ),
                      children: []),
                  Table(
                    border: TableBorder(
                        top: BorderSide(width: 1),
                        horizontalInside: BorderSide(width: 1)),
                    children: getRecommendation(
                        uviInfo.uvi, childExtraInfo, screenWidth, screenHeight),
                  )
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  FototipoOptionViewmodel userFotoModel(ChildDto childDto) {
    return FototipoOptionViewmodel(name: childDto.scoreDescription);
  }

  Widget FototipoBoardPart1() {
    return Column(
      children: [
        Table(
          border: TableBorder.all(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          //columnWidths: {2: FixedColumnWidth(120.0)},
          children: [
            _tableRow([
              Color(0xffbca48c),
              Color(0xffac8c73),
              Color(0xff9c7e62),
            ], colorRow: Colors.green, heighContainer: 50),
            _tableRow(["Skin Type |", "Skin Type ||", "Skin Type |||"],
                colorRow: Colors.black,
                colorText: Colors.white,
                heighContainer: 40),
          ],
        )
      ],
    );
  }

  Widget FototipoBoardPart2() {
    return Column(
      children: [
        Table(
          border: TableBorder.all(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          //columnWidths: {2: FixedColumnWidth(120.0)},
          children: [
            _tableRow([
              Color(0xff846444),
              Color(0xff744c24),
              Color(0xff341c1c),
            ], colorRow: Colors.green, heighContainer: 50),
            _tableRow(["Skin Type |V", "Skin Type V", "Skin Type V|"],
                colorRow: Colors.black,
                colorText: Colors.white,
                heighContainer: 40),
          ],
        )
      ],
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

  deleteChildDialog(childId) {
    return showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text("Eliminar Perfil del Hijo"),
            content: Text("¿Estas seguro de eliminar el perfil de este hijo?"),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.pop(dialogContext);

                    //Utils.homeNavigator.currentState!.pushNamedAndRemoveUntil(routeProfile, (route) =>false);
                    CreateChildBloc()
                        .deleteChild(childId)
                        .then((response) async {
                      if (response) {
                        NotificationUtil().showSnackbar(
                            Utils.homeNavigator.currentContext!,
                            "Se ha eliminado el hijo correctamente",
                            "success");
                      } else {
                        NotificationUtil().showSnackbar(
                            Utils.homeNavigator.currentContext!,
                            "Ha ocurrido un error en la eliminación",
                            "error");
                      }
                    });
                    await Future.delayed(Duration(milliseconds: 200));
                    Utils.homeNavigator.currentState!
                        .pushReplacementNamed(routeProfile);
                  },
                  child: Text("Si")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    ChildDto arguments = ModalRoute.of(context)!.settings.arguments as ChildDto;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.withOpacity(0),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    //const ProfileComponent(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Datos del menor',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 60),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  iconSize: 30,
                                  onPressed: () {
                                    //Navigator.push(context,MaterialPageRoute(builder: (context) => ChildrenUpdateView(arguments)));
                                    Utils.homeNavigator.currentState!.pushNamed(
                                        routeChildrenUpdateUpdate,
                                        arguments: arguments);
                                  },
                                ),
                              ],
                            ),
                            /*Icon(
                              Icons.edit,
                              size: 40,
                              color: Colors.black,
                            ),*/
                          ],
                        ),
                        Text('Nombre Completo: ${arguments.name}'),
                        Text('Fecha de Nacimiento: ' +
                            formatNacimiento(arguments.birthday)),
                        Text(
                            'Edad: ${ChildBloc().getEdad(arguments.birthday)} años'),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return Dialog(
                                insetPadding: EdgeInsets.all(10),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: screenWidth,
                                  height: screenHeight * 0.6,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(
                                          "¿Qué es un Fototipo?",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                            "El fototipo es la capacidad de adaptación al sol que tiene cada persona desde que nace, es decir, el conjunto de características que determinan si una piel se broncea o no, y cómo y en qué grado lo hace. Cuanto más baja sea esta capacidad, menos se contrarrestarán los efectos de las radiaciones solares en la piel (Marín & Del Pozo, 2005). La clasificación más famosa de los fototipos cutáneos es la del Dr. Thomas Fitzpatrick, mostrada en la siguiente tabla:"),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        FototipoBoardPart1(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        FototipoBoardPart2(),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "Tonos de piel referenciales",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text(
                        '¿Qué es un fototipo?',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Align(
                      //alignment: Alignment.topRight,
                      child: IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteChildDialog(arguments.id);
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: Colors.black,
                ),
                SizedBox(height: 15),
                UserFototipoComponent(
                  nombreHijo: arguments.name,
                  model: userFotoModel(arguments),
                ),
                SizedBox(height: 30),
                Wrap(
                  children: [
                    Text("Más información (pág 18): "),
                    GestureDetector(
                      onTap: () {
                        LoginBloc().launchURL(
                            "https://portal.inen.sld.pe/wp-content/uploads/2019/10/Cancer-de-piel-2018-op2_final.pdf");
                      },
                      child: Text(
                        'https://portal.inen.sld.pe/wp-content/uploads/2019/10/Cancer-de-piel-2018-op2_final.pdf',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: Colors.black,
                ),
                SizedBox(height: 15),
                Text(
                  'Recomendaciones e indicaciones para su hijo de acuerdo al UVI actual y su fototipo de piel:',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 15),
                recomendaciones(arguments.id, screenWidth, screenHeight),
              ],
            ),
          ),
        ));
  }
}
