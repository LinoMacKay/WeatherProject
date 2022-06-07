import 'package:flutter/material.dart';

class ActionCommentComponent extends StatelessWidget {


  final String textAction;
  final String action;

  const ActionCommentComponent({Key? key, this.textAction='', this.action=''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(textAction),

          Row(
            children: [
              Text(action),
              IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                  }),
            ],
          )
        ],
      ),
    );
  }
}