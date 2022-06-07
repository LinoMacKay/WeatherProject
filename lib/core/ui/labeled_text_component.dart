import 'package:flutter/material.dart';
import 'package:my_project/core/ui/decorated_text_component.dart';

class LabeledTextComponent extends StatelessWidget {
  final String label;
  final String text;
  const LabeledTextComponent({Key? key, this.label = '', this.text = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.start,
          children: <Widget>[
            DecoratedTextComponent(text: label),
            SizedBox(width: 5),
            Text(text,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
