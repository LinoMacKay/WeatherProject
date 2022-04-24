import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/model/ChildDto.dart';
import 'package:my_project/router/routes.dart';
import 'package:my_project/utils/Utils.dart';

import '../../core/bloc/createChildBloc.dart';
import '../../utils/NotificationHelper.dart';

class SingleChildCard extends StatefulWidget {
  ChildDto childDto;
  SingleChildCard(this.childDto);

  @override
  State<SingleChildCard> createState() => _SingleChildCardState();
}

class _SingleChildCardState extends State<SingleChildCard> {
  @override
  void dispose() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Utils.homeNavigator.currentState!
            .pushNamed(routeChildrenDetail, arguments: widget.childDto);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: screenWidth,
              height: screenHeight * 0.09,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.5),
                      child: Container(
                        child: CircleAvatar(
                          child: Icon(
                            Icons.person,
                            size: 40,
                          ),
                          radius: screenHeight * 0.05,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.childDto.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat('dd-MM-yyyy', 'es_ES').format(
                                  DateTime.tryParse(widget.childDto.birthday)!),
                              style: TextStyle(
                                  color: Color.fromRGBO(161, 164, 182, 1),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    color: Colors.red,
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Eliminar Perfil del Hijo"),
                            content: Text(
                                "¿Estas seguro de eliminar el perfil de este hijo?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    //Utils.homeNavigator.currentState!.pushNamedAndRemoveUntil(routeProfile, (route) =>false);
                                    CreateChildBloc()
                                        .deleteChild(widget.childDto.id)
                                        .then((response) async {
                                      if (response) {
                                        Utils.homeNavigator.currentState!
                                            .pushReplacementNamed(routeProfile);
                                        await Future.delayed(
                                            Duration(milliseconds: 200));
                                        NotificationUtil().showSnackbar(
                                            context,
                                            "Se ha eliminado el hijo correctamente",
                                            "success",
                                            null);
                                      } else {
                                        NotificationUtil().showSnackbar(
                                            context,
                                            "Ha ocurrido un error en la eliminación",
                                            "error",
                                            null);
                                      }
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Si")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No")),
                            ],
                          );
                        },
                      );
                      //deleteChildDialog(arguments.id);
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
