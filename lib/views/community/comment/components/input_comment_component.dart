import 'package:flutter/material.dart';

class InputCommentComponent extends StatefulWidget {

  final String inputText;
  const InputCommentComponent({Key? key, this.inputText = ''}) : super(key: key);

  @override
  State<InputCommentComponent> createState() => _InputCommentComponentState();
}

class _InputCommentComponentState extends State<InputCommentComponent> {

  var _controller ;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.inputText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 80),//width: 300,
        child: TextField(
          //style: TextStyle(color: Colors.white,),
          maxLines: null,
          maxLength: 200,
          controller: _controller,
          cursorColor: Colors.black,
          decoration: InputDecoration(
              hintText: "Escribir comentario",
              fillColor: Colors.blue, filled: true,
              isDense: true,
              contentPadding: EdgeInsets.all(15),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              )
          ),
        ),

      ),
    );
  }


}