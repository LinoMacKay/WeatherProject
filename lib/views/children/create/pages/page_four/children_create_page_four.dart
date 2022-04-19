import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:my_project/core/bloc/createChildBloc.dart';
import 'package:my_project/data/viewmodels/create_children_quote.dart';
import 'package:my_project/data/viewmodels/fototipo_option.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/model/CreateChildDto.dart';
import 'package:my_project/router/routes.dart';
import 'package:my_project/utils/Utils.dart';
import 'package:my_project/views/children/create/pages/page_one/children_create_page_one_form.dart';
import 'package:my_project/views/children/create/pages/page_three/components/fototipo_option_component.dart';

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

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var index = 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
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
                          child: Column(
                            children: [
                              Text(
                                "¿Qué es el Fototipo?",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Text(
                '¿Qué es fototipo?',
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Nombre: ${widget.form.nameController.text}'),
                      Text('Fecha de Nacimiento: ${widget.form.dateFormatted}'),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
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
                FototipoOptionComponent(model: widget.fototipoOptionViewmodel),
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
                      CreateChildBloc()
                          .createChild(createChild())
                          .then((value) {
                        if (value)
                          Utils.homeNavigator.currentState!
                              .pushReplacementNamed(routeHome);
                        else {
                          print("error");
                        }
                      });
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
