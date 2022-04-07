import 'package:flutter/material.dart';

class LabeledTextFormComponent extends StatelessWidget {
  final String label;
  final String hint;
  final double width;
  final double formWidth;
  const LabeledTextFormComponent({
    Key? key,
    this.label = '',
    this.hint = '',
    this.width = 200,
    this.formWidth = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(label),
          Container(
            width: formWidth,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            child: Text(hint),
          ),
        ],
      ),
    );
  }
}