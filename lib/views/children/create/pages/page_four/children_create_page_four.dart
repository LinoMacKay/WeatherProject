import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:my_project/core/bloc/createChildBloc.dart';
import 'package:my_project/data/viewmodels/create_children_quote.dart';
import 'package:my_project/data/viewmodels/fototipo_option.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/model/CreateChildDto.dart';
import 'package:my_project/router/routes.dart';
import 'package:my_project/utils/NotificationHelper.dart';
import 'package:my_project/utils/Utils.dart';
import 'package:my_project/views/children/create/pages/page_one/children_create_page_one_form.dart';
import 'package:my_project/views/children/create/pages/page_three/components/fototipo_option_component.dart';

import '../../../../Home.dart';

class ChildrenCreatePageFour extends StatefulWidget {
  final ChildrenCreatePageOneForm form;
  final List<QuoteOption?> selectedOptions;
  final FototipoOptionViewmodel fototipoOptionViewmodel;
  final VoidCallback? onContinue, onBack;
  const ChildrenCreatePageFour({
    Key? key,
    this.onContinue,
    this.onBack,
    required this.form,
    required this.selectedOptions,
    required this.fototipoOptionViewmodel,
  }) : super(key: key);

  @override
  State<ChildrenCreatePageFour> createState() => _ChildrenCreatePageFourState();
}

class _ChildrenCreatePageFourState extends State<ChildrenCreatePageFour> {
  var isLoading = false;
  @override
  void initState() {
    BackButtonInterceptor.add(myInterceptor);

    super.initState();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return true;
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  String getTotalPoints() {
    var puntosTotales = 0;
    widget.selectedOptions.forEach((element) {
      puntosTotales = element!.point + puntosTotales;
    });
    var fototipo = "";
    if (puntosTotales <= 6) {
      fototipo = "I";
    } else if (puntosTotales <= 13) {
      fototipo = "II";
    } else if (puntosTotales <= 20) {
      fototipo = "III";
    } else if (puntosTotales <= 27) {
      fototipo = "IV";
    } else if (puntosTotales <= 34) {
      fototipo = "V";
    } else {
      fototipo = "VI";
    }
    widget.fototipoOptionViewmodel.name = fototipo;
    return puntosTotales.toString();
  }

  CreateChildDto createChild() {
    CreateChildDto createChildDto = CreateChildDto();
    createChildDto.birthday = widget.form.dateFormattedForBackend;
    createChildDto.name = widget.form.nameController.text;
    createChildDto.score = getTotalPoints();

    return createChildDto;
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

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var index = 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                const Text('Registro de hijo (paso 4 de 4) - Confirmación'),
                const SizedBox(height: 20),
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
                                            fontSize: 12, color: Colors.grey),
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
                const SizedBox(height: 20),
                const Text('Se procederá a registrar la información:'),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Datos Generales'),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Nombre: ${widget.form.nameController.text}'),
                          Text(
                              'Fecha de Nacimiento: ${widget.form.dateFormatted}'),
                          Text(
                              'Edad: ${widget.form.age} ${widget.form.age < 2 ? "año" : "años"}'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Cuestionario'),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.selectedOptions
                            .map<Widget>((e) => Text(
                                'Pregunta ${index++}: ${e?.description ?? ""}'))
                            .toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.center,
                  child: Text('Escala Fitzpatrick'),
                ),
                const SizedBox(height: 20),
                Text('Puntos: ' + getTotalPoints()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Fototipo',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    FototipoOptionComponent(
                        model: widget.fototipoOptionViewmodel),
                  ],
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text('¿Es correcta la información?'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingActionButton(
                        backgroundColor: Colors.red,
                        child: Icon(Icons.close),
                        onPressed: widget.onBack),
                    FloatingActionButton(
                        backgroundColor: Colors.red,
                        child: Icon(Icons.done),
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          CreateChildBloc()
                              .createChild(createChild())
                              .then((value) async {
                            if (value) {
                              /*NotificationUtil().showSnackbar(
                                  context,
                                  "Se ha creado el hijo correctamente",
                                  "success",
                                  null);*/
                              NotificationUtil().showSnackbar(
                                  Utils.homeNavigator.currentContext!,
                                  "Se ha creado el hijo correctamente",
                                  "success");
                              await Future.delayed(Duration(milliseconds: 200));
                              Utils.homeNavigator.currentState!
                                  .pushReplacementNamed(routeHome);
                            } else {
                              NotificationUtil().showSnackbar(
                                  Utils.homeNavigator.currentContext!,
                                  "Ha ocurrido un error en la creación",
                                  "error");
                              /*NotificationUtil().showSnackbar(
                                  context,
                                  "Ha ocurrido un error en la creación",
                                  "error",
                                  null);*/
                            }
                            setState(() {
                              isLoading = false;
                            });
                          });
                        }),
                  ],
                ),
              ],
            ),
            if (isLoading) Utils().loader(screenWidth, screenHeight)
          ],
        ),
      ),
    );
  }
}
