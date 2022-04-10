import 'package:flutter/material.dart';

class DecoratedTextComponent extends StatelessWidget {
  final String text;
  final double? width;
  const DecoratedTextComponent({
    Key? key,
    this.text = '',
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Text(text),
    );
  }
}
