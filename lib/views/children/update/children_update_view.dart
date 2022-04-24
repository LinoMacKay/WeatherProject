import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/data/viewmodels/fototipo_option.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/utils/NotificationHelper.dart';

import '../../../core/bloc/createChildBloc.dart';
import '../../../core/provider/childProvider.dart';
import '../../../model/ChildDto.dart';
import '../../../model/UpdateChildDto.dart';
import '../../../router/routes.dart';
import '../../../utils/Utils.dart';

class ChildrenUpdateView extends StatefulWidget {
  ChildrenUpdateView({Key? key}) : super(key: key);

  @override
  State<ChildrenUpdateView> createState() => _ChildrenUpdateViewState();
}

class _ChildrenUpdateViewState extends State<ChildrenUpdateView> {
  final formkey = GlobalKey<FormState>();

  UpdateChildDto updateChildDto = UpdateChildDto();

  ChildProvider childProvider = ChildProvider();

  TextEditingController _dateController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChildDto child = ModalRoute.of(context)!.settings.arguments as ChildDto;
    _dateController.text = DateFormat('dd-MM-yyyy', 'es_ES')
        .format(DateTime.parse(child.birthday));
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              const Text('Edición de datos de su hijo'),
              const SizedBox(height: 10),
              Form(
                key: formkey,
                child: Column(
                  //Row
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                        initialValue: child.name,
                        decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                            labelText: 'Usuario'),
                        onSaved: (value) =>
                            updateChildDto.name = value.toString(),
                        validator: (value) {
                          print(value);
                          if (value!.isEmpty) {
                            return 'El nombre es requerido';
                          } else {
                            return null;
                          }
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                      key: Key(updateChildDto.birthday.toString()),
                      controller: _dateController,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color),
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        updateChildDto.birthday =
                            DateTime.parse(value).toString();
                      },
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.parse(child.birthday),
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now())
                            .then((date) {
                          String dateFormat =
                              "${date!.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                          updateChildDto.birthday = dateFormat;
                          _dateController.text = dateFormat;
                        });
                      },
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          labelText: 'Fecha de nacimiento',
                          labelStyle: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        AppButton(
                            onPressed: () {
                              Utils.homeNavigator.currentState!.pop();
                            },
                            text: 'Cancelar',
                            width: 120,
                            color: Colors.red),
                        AppButton(
                            onPressed: () {
                              formkey.currentState?.save();
                              print(updateChildDto);
                              updateChildDto.id = child.id;
                              CreateChildBloc()
                                  .updateChild(updateChildDto)
                                  .then((value) async {
                                if (value) {
                                  await Future.delayed(
                                      Duration(milliseconds: 200));
                                  NotificationUtil().showSnackbar(
                                      context,
                                      "Se ha editado el hijo correctamente",
                                      "success",
                                      null);
                                } else {
                                  NotificationUtil().showSnackbar(
                                      context,
                                      "Ha ocurrido un error en la edición",
                                      "error",
                                      null);
                                }
                                Utils.homeNavigator.currentState!
                                    .popAndPushNamed(routeProfile);
                              });
                            },
                            text: 'Continuar',
                            width: 120),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatNacimiento(birthday) {
  var fecha = DateTime.tryParse(birthday);
  return fecha!.day.toString() +
      " de " +
      DateFormat('MMMM', 'es_ES').format(DateTime.tryParse(birthday)!) +
      " del " +
      fecha.year.toString();
}
