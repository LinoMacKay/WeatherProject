import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/views/community/comment/components/action_comment_component.dart';
import 'package:my_project/views/community/comment/components/input_comment_component.dart';
import 'package:my_project/views/community/comment/components/text_comment_component.dart';

class CommentView extends StatefulWidget {
  const CommentView({Key? key}) : super(key: key);

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {

  int indexComment = 10;
  final titleComment = "Comentario para el Post de Pablo Lopez de hace 15 min";
  final textComment = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenea";


  final textAction = "Escribe tu comentario aqui: ";
  final action = "Enviar";
  final inputText = '';

  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Scaffold(
          body:

          ////////////////Al parecer un itembuilder no puede estar dentro de un column
          ListView.builder(
              itemCount: indexComment,
              itemBuilder: (BuildContext itemBuilder, context) {
                return TextCommentComponent(
                  titleComment: titleComment, textComment: textComment,);
              }),


          bottomNavigationBar: Container(
            //color: Colors.black,
            height: 130,
            //padding: EdgeInsets.only(right: 0),// serivra para dps
            //margin:  EdgeInsets.only(right: 3.0),
            child:
            Column(
              children: [

                ActionCommentComponent(textAction: textAction, action: action),

                InputCommentComponent(inputText: inputText,)


              ],
            ),


          ),


        )


    );
  }
}