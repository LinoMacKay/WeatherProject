import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:my_project/core/bloc/createChildBloc.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/model/CreateChildDto.dart';
import 'package:my_project/utils/Utils.dart';
import 'package:my_project/views/children/create/pages/page_one/children_create_page_one_form.dart';

class ChildrenCreatePageOne extends StatefulWidget {
  final ChildrenCreatePageOneForm form;
  final Function? onContinue;
  final CreateChildBloc? bloc;
  ChildrenCreatePageOne(
      {Key? key, required this.form, this.onContinue, this.bloc})
      : super(key: key);

  @override
  State<ChildrenCreatePageOne> createState() => _ChildrenCreatePageOneState();
}

class _ChildrenCreatePageOneState extends State<ChildrenCreatePageOne> {
  CreateChildDto createChildDto = CreateChildDto();
  TextEditingController _dateController = TextEditingController();
  @override
  void initState() {
    String dateFormat =
        "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
    widget.bloc!.changeBirthday(dateFormat);
    createChildDto.birthday = dateFormat;
    BackButtonInterceptor.add(myInterceptor);

    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Utils.homeNavigator.currentState!.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: SizedBox(
        height: screenHeight,
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
            const SizedBox(height: 10),
            StreamBuilder(
                stream: widget.bloc?.nameStream,
                builder: (context, snapshot) {
                  return TextFormField(
                    //     key: Key(widget.user.lastName),
                    onChanged: (val) => widget.bloc!.changeName(val),
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color),
                    //readOnly: !isEditable,
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      // _updateDto.lastName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por favor ingrese el nombre de su hijo";
                      }
                    },
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        errorText: snapshot.hasError
                            ? snapshot.error.toString()
                            : null,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        labelText: 'Nombre del hijo',
                        labelStyle: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText1!.color)),
                  );
                }),
            SizedBox(
              height: 30,
            ),
            StreamBuilder(
                stream: widget.bloc!.birthdayStream,
                builder: (ctx, snapshot) {
                  _dateController.text = createChildDto.birthday;
                  return TextFormField(
                    key: Key(createChildDto.birthday),
                    controller: _dateController,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      createChildDto.birthday = value!;
                    },
                    onChanged: (value) {
                      widget.bloc!.sinkBirthday.add(value);
                    },
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate:
                                  DateTime.parse(widget.bloc!.getBirthday),
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now())
                          .then((date) {
                        String dateFormat =
                            "${date!.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                        createChildDto.birthday = dateFormat;
                        widget.bloc!.changeBirthday(dateFormat);
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por favor ingrese su fecha de nacimiento";
                      }
                    },
                    decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        errorText: snapshot.hasError
                            ? snapshot.error.toString()
                            : null,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        labelText: 'Fecha de nacimiento',
                        labelStyle: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText1!.color)),
                  );
                }),
            SizedBox(
              height: screenHeight * 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                    stream: widget.bloc!.formValidStream,
                    builder: (ctx, snapshot) {
                      bool validator = false;

                      if (snapshot.hasData) validator = snapshot.data as bool;
                      print(validator);
                      return validator
                          ? FloatingActionButton(
                              backgroundColor: Colors.red,
                              child: Icon(Icons.arrow_forward),
                              onPressed: () {
                                widget.onContinue!();
                                widget.form.nameController.text =
                                    widget.bloc!.name;
                                widget.form.dateTimeController =
                                    DateTime.parse(widget.bloc!.getBirthday);

                                widget.bloc!.changeName('');
                              })
                          : FloatingActionButton(
                              backgroundColor: Colors.red,
                              child: Icon(Icons.cancel_rounded),
                              onPressed: () {
                                Utils.homeNavigator.currentState!.pop();
                              },
                            );
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
