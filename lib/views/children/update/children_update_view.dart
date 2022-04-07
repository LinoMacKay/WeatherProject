import 'package:flutter/material.dart';
import 'package:my_project/core/ui/profile_component.dart';
import 'package:my_project/core/ui/user_fototipo_component.dart';
import 'package:my_project/data/viewmodels/fototipo_option.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/views/children/create/pages/page_three/components/fototipo_option_component.dart';

class ChildrenUpdateView extends StatefulWidget {
  const ChildrenUpdateView({Key? key}) : super(key: key);

  @override
  _ChildrenUpdateViewState createState() => _ChildrenUpdateViewState();
}

class _ChildrenUpdateViewState extends State<ChildrenUpdateView> {
  final nameController = TextEditingController();
  final nameFocusNode = FocusNode();

  final dateController = DateTime.now();

  final model = FototipoOptionViewmodel();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              const Text('Edición de datos de su hijo'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const ProfileComponent(),
                  Column(
                    children: const <Widget>[
                      Icon(Icons.camera_alt, size: 40),
                      Text('Cambiar foto'),
                    ],
                  ),
                  Column(
                    children: const <Widget>[
                      Icon(Icons.camera, size: 40),
                      Text('Seleccionar ícono'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  AppTextForm(
                    width: 300,
                    label: 'Nombre',
                    controller: nameController,
                    focusNode: nameFocusNode,
                    style: const TextStyle(),
                    preffix: Icons.person,
                  ),
                  const SizedBox(height: 10),
                  AppDateForm(
                    preffix: Icons.calendar_view_day,
                    suffix: Icons.calendar_today,
                    controller: dateController,
                    label: 'Fecha de Nacimiento',
                    style: const TextStyle(),
                  ),
                  const SizedBox(height: 20),
                  UserFototipoComponent(model: model),
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      AppButton(onPressed: () {}, text: 'Cancelar', width: 100),
                      AppButton(onPressed: () {}, text: 'Continuar', width: 100),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
