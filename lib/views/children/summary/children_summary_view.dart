import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/core/ui/profile_component.dart';
import 'package:my_project/core/ui/user_fototipo_component.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/model/ChildDto.dart';
import 'package:my_project/utils/Utils.dart';

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

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  Widget recomendaciones() {
    return Column(
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
                      child: Text('Tiempo Máximo de Exposición al Sol'),
                    ),
                  ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Según el fototipo de su hijo, se recomienda que esté entre 10 a 15 minutos como máximo expuesto al sol'),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('¿Qué zonas de mi hijo debo proteger del sol?'),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      '¿Cómo saber si la piel de mi hijo ha sido afectada por el sol?'),
                ),
              ]),
            ]),
      ],
    );
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

  @override
  Widget build(BuildContext context) {
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
                                    Utils.homeNavigator.currentState!
                                        .pushNamed(
                                      routeChildrenUpdateUpdate,arguments: arguments
                                    );
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
                        Text('Edad: ${getEdad(arguments.birthday)} años'),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.delete,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
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
                const UserFototipoComponent(),
                SizedBox(height: 30),
                Text(
                    'Más información: https://www.dermcollective.com/flitzpatrick.skin-types/'),
                SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: Colors.black,
                ),
                SizedBox(height: 15),
                Text('Recomendaciones e indicaciones para su hijo'),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: recomendaciones(),
                ),
              ],
            ),
          ),
        ));
  }
}
