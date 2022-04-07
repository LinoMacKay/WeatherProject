import 'package:flutter/material.dart';

class SeparatedWrap extends StatelessWidget {
  final List<Widget> children;
  const SeparatedWrap({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(
        children.length ~/ 2,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: (index + 1 < children.length - 1)
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            children: <Widget>[
              children[index],
              if (index + 1 < children.length - 1) children[index + 1]
            ],
          ),
        ),
      ),
    );
  }
}
