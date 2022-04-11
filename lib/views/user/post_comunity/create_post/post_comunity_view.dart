import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../helper/ui/ui_library.dart';

class PostComunityView extends StatelessWidget {
  const PostComunityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: SingleChildScrollView(
            child: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Text('¿Qué deseas publicar?'),
                ],
              ),
              Row(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Post creado correctamente'),
                              
                              content: Text("Se ha creado correctamente tu post"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Text('Publicar'),
                  ),
                  Icon(Icons.send),
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ingresar publicación',
                  contentPadding: EdgeInsets.all(5),
                ),
                maxLines: 15,
              ),
            ],
          ),
        ],
      ),
    )));
  }
}
