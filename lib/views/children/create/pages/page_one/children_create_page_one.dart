import 'package:flutter/material.dart';
import 'package:my_project/core/bloc/createChildBloc.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/utils/Utils.dart';
import 'package:my_project/views/children/create/pages/page_one/children_create_page_one_form.dart';

class ChildrenCreatePageOne extends StatelessWidget {
  final ChildrenCreatePageOneForm form;
  final VoidCallback? onContinue;
  final CreateChildBloc? bloc;
  const ChildrenCreatePageOne(
      {Key? key, required this.form, this.onContinue, this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            stream: bloc?.nameStream,
            builder: (context, snapshot) {
              return TextFormField(
                //     key: Key(widget.user.lastName),
                onChanged: (val) => bloc!.changeName(val),
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
                    errorText:
                        snapshot.hasError ? snapshot.error.toString() : null,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    labelText: 'Nombre del hijo',
                    labelStyle: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color)),
              );
            }),
        SizedBox(
          height: 10,
        ),
        StreamBuilder(
            stream: bloc?.dateStream,
            builder: (context, snapshot) {
              return TextFormField(
                //     key: Key(widget.user.lastName),
                onChanged: (val) => bloc!.changeDate(val),
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
                    icon: Icon(Icons.calendar_month),
                    errorText:
                        snapshot.hasError ? snapshot.error.toString() : null,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    labelText: 'Fecha de nacimiento',
                    labelStyle: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color)),
              );
            }),
        Expanded(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Ink(
              height: 50,
              width: 50,
              decoration: ShapeDecoration(
                color: Colors.red,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(Icons.cancel_rounded),
                color: Colors.white,
                onPressed: () {
                  Utils.homeNavigator.currentState!.pop();
                },
              ),
            ),
            Ink(
              height: 50,
              width: 50,
              decoration: ShapeDecoration(
                color: Colors.red,
                shape: CircleBorder(),
              ),
              child: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  color: Colors.white,
                  onPressed: onContinue),
            ),
          ],
        )
      ],
    );
  }
}
