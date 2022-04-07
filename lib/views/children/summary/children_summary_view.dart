import 'package:flutter/material.dart';
import 'package:my_project/core/ui/profile_component.dart';
import 'package:my_project/core/ui/user_fototipo_component.dart';
import 'package:my_project/helper/ui/ui_library.dart';

class ChildrenSummaryView extends StatefulWidget {
  const ChildrenSummaryView({Key? key}) : super(key: key);

  @override
  State<ChildrenSummaryView> createState() => _ChildrenSummaryViewState();
}

class _ChildrenSummaryViewState extends State<ChildrenSummaryView> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const ProfileComponent(),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text('Datos del menor'),
                            SizedBox(height: 10),
                          ],
                        ),
                        Icon(
                          Icons.edit,
                          size: 40,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    Text('Nombre Completo: Karla Silvia Lopez'),
                    Text('Fecha de Nacimiento: 15 de Octubre del 2014'),
                    Text('Edad: 7 años'),
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
              height: 1.5,
              color: Colors.black,
            ),
            const UserFototipoComponent(),
            SizedBox(height: 30),
            Text('Más información: https://www.dermcollective.com/flitzpatrick.skin-types/'),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1.5,
              color: Colors.black,
            ),
            Text('Recomendaciones e indicaciones para su hijo'),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Tiempo Máximo de Exposición al Sol'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Según el fototipo de su hijo, se recomienda que esté entre 10 a 15 minutos como máximo expuesto al sol'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('¿Qué zonas de mi hijo debo proteger del sol?'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('¿Cómo saber si la piel de mi hijo ha sido afectada por el sol?'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      )
    );
  }
}