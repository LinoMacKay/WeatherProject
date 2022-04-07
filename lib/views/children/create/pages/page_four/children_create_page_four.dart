import 'package:flutter/material.dart';
import 'package:my_project/data/viewmodels/create_children_quote.dart';
import 'package:my_project/data/viewmodels/fototipo_option.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/router/routes.dart';
import 'package:my_project/utils/Utils.dart';
import 'package:my_project/views/children/create/pages/page_one/children_create_page_one_form.dart';
import 'package:my_project/views/children/create/pages/page_three/components/fototipo_option_component.dart';

class ChildrenCreatePageFour extends StatelessWidget {
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
  Widget build(BuildContext context) {
    var index = 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          const Text('Registro de hijo (paso 4 de 4) - Confirmación'),
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
                    Text('Nombre: ${form.nameController.text}'),
                    Text('Fecha de Nacimiento: ${form.dateFormatted}'),
                    Text('Edad: ${form.age} ${form.age < 2 ? "año" : "años"}'),
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
                  children: selectedOptions
                      .map<Widget>((e) =>
                          Text('Pregunta ${index++}: ${e?.description ?? ""}'))
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Fototipo'),
              FototipoOptionComponent(model: fototipoOptionViewmodel),
            ],
          ),
          const SizedBox(height: 140),
          const Align(
            alignment: Alignment.center,
            child: Text('¿Es correcta la información?'),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              AppButton(onPressed: onBack, text: 'Regresar', width: 100),
              AppButton(
                  onPressed: () {
                    Utils.homeNavigator.currentState!
                        .pushReplacementNamed(routeHome);
                  },
                  text: 'Continuar',
                  width: 100),
            ],
          ),
        ],
      ),
    );
  }
}
