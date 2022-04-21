import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/core/bloc/locationBloc.dart';
import 'package:my_project/core/provider/childProvider.dart';
import 'package:my_project/core/ui/profile_component.dart';
import 'package:my_project/core/ui/user_fototipo_component.dart';
import 'package:my_project/data/viewmodels/fototipo_option.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/model/ChildDto.dart';
import 'package:my_project/model/UviDto.dart';
import 'package:my_project/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  List<TableRow> getRecommendation(uvi, fps) {
    var recommendation1 = "";
    var recommendation2 = "";

    if (fps == "50") {
      fps = "50+";
    }

    if (uvi <= 2) {
      recommendation1 = "Puedes quedarte afuera con seguridad";
      recommendation2 = "¡No necesitas protector solar de ${fps} fps!";
    } else if (uvi <= 7) {
      recommendation1 = "¡Busca la sombra durante las horas del mediodia!";
      recommendation2 =
          "¡Ponte una camisa, protector solar de ${fps} fps y un sombrero!";
    } else {
      recommendation1 = "¡Evita estar afuera durante las horas del mediodia!";
      recommendation2 = "¡Asegurate de buscar sombra!\n" +
          "¡Camisa, protector solar de ${fps} fps y sombrero son imprescendibles!";
    }

    return [
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

  Widget recomendaciones(childId) {
    return FutureBuilder(
        future: Future.wait([
          ChildProvider().getSingleChild(childId),
          LocationBloc().getUviInfoFromSP()
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data as List;
            var childInfo = data[0] as ChildExtraInfoDto;
            var uvInfo = LocationBloc().getFechaMasCercana(data[1], {}, []);
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
                      children: [
                        TableRow(
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            children: [
                              Container(
                                margin: const EdgeInsets.all(8.0),
                                child:
                                    Text('Tiempo Máximo de Exposición al Sol'),
                              ),
                            ]),
                      ]),
                  Table(
                    border: TableBorder(
                        top: BorderSide(width: 1),
                        horizontalInside: BorderSide(width: 1)),
                    children: getRecommendation(uvInfo.uvi, childInfo.fps),
                  )
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  String formatNacimiento(birthday) {
    var fecha = DateTime.tryParse(birthday);
    return fecha!.day.toString() +
        " de " +
        DateFormat('MMMM', 'es_ES').format(DateTime.tryParse(birthday)!) +
        " del " +
        fecha.year.toString();
  }

  int getEdad(birthday) {
    var fecha = DateTime.tryParse(birthday);
    final now = DateTime.now();

    int years = now.year - fecha!.year;
    int months = now.month - fecha.month;
    int days = now.day - fecha.day;

    if (months < 0 || (months == 0 && days < 0)) {
      years--;
      months += (days < 0 ? 11 : 12);
    }

    if (days < 0) {
      final monthAgo = DateTime(now.year, now.month - 1, fecha.day);
      days = now.difference(monthAgo).inDays + 1;
    }

    return years;
  }

  FototipoOptionViewmodel userFotoModel(ChildDto childDto) {
    return FototipoOptionViewmodel(name: childDto.scoreDescription);
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    ChildDto arguments = ModalRoute.of(context)!.settings.arguments as ChildDto;
    print(arguments);
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Datos del menor',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
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
                        Text('Edad: ${getEdad(arguments.birthday)} años'),
                        SizedBox(
                          height: 15,
                        )
                        /*
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.delete,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),*/
                      ],
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
                    Text("Más información: "),
                    GestureDetector(
                      onTap: () {
                        launchURL(
                            "https://www.dermcollective.com/flitzpatrick.skin-types/");
                      },
                      child: Text(
                        'https://www.dermcollective.com/flitzpatrick.skin-types/',
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
                Text('Recomendaciones e indicaciones para su hijo'),
                SizedBox(height: 15),
                recomendaciones(arguments.id),
              ],
            ),
          ),
        ));
  }
}
