import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextCommentComponent extends StatelessWidget {

  final String titleComment;
  final String  textComment;

  const TextCommentComponent({Key? key, this.titleComment = '', this.textComment = ''}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titleComment),
          Container(
            padding: EdgeInsets.all(6.0),
            margin:  EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                border: Border.all()
            ),
            child: Text(textComment),
          )
        ],
      ),
    );
  }
}