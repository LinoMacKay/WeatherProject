import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../helper/ui/ui_library.dart';

class EditComunityView extends StatelessWidget {
  const EditComunityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textdefault = "Lorem ipsum dolor sit amet, consecteturs adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum!";
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
                  Text('Editando Post'),
                ],
              ),
              Row(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      //Alerta para mostrar que se ha editado el post
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Post editado correctamente'),
                              
                              content: Text("Se ha editado correctamente tu post"),
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
                controller: TextEditingController(text: textdefault),
                decoration: const InputDecoration(
                
                  border: OutlineInputBorder(),
                  
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
