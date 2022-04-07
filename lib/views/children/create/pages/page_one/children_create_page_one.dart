import 'package:flutter/material.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/utils/Utils.dart';
import 'package:my_project/views/children/create/pages/page_one/children_create_page_one_form.dart';

class ChildrenCreatePageOne extends StatelessWidget {
  final ChildrenCreatePageOneForm form;
  final VoidCallback? onContinue;
  const ChildrenCreatePageOne({Key? key, required this.form, this.onContinue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Registro de hijo (paso 1 de 4) - Datos Generales'),
          ),
          const Icon(Icons.person_outline, size: 120),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              AppIconButton(
                iconSize: 40,
                onPressed: null,
                icon: Icons.camera_alt,
                text: 'Agregar foto',
              ),
              AppIconButton(
                iconSize: 40,
                onPressed: null,
                icon: Icons.store,
                text: 'Seleccionar ícono',
              ),
            ],
          ),
          AppTextForm(
            controller: form.nameController,
            focusNode: form.nameFocusNode,
            style: const TextStyle(),
            preffix: Icons.person,
          ),
          AppDateForm(
            preffix: Icons.calendar_view_day,
            suffix: Icons.calendar_today,
            controller: form.dateTimeController,
            label: 'Fecha de Nacimiento',
            style: const TextStyle(),
          ),
          const SizedBox(height: 300),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              AppButton(
                  onPressed: () {
                    Utils.homeNavigator.currentState!.pop();
                  },
                  text: 'Cancelar',
                  width: 100),
              AppButton(onPressed: onContinue, text: 'Continuar', width: 100),
            ],
          ),
        ],
      ),
    );
  }
}
