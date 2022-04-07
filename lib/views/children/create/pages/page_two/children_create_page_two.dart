import 'package:flutter/material.dart';
import 'package:my_project/data/viewmodels/create_children_quote.dart';
import 'package:my_project/helper/constants/objects.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/views/children/create/pages/page_one/children_create_page_one_form.dart';
import 'package:my_project/views/children/create/pages/page_two/children_create_page_two_quote.dart';

class ChildrenCreatePageTwo extends StatefulWidget {
  final VoidCallback? onBack, onContinue;
  final List<QuoteOption?> quotesSelected;
  const ChildrenCreatePageTwo({
    Key? key,
    this.onBack,
    this.onContinue,
    required this.quotesSelected,
  }) : super(key: key);

  @override
  _ChildrenCreatePageTwoState createState() => _ChildrenCreatePageTwoState();
}

class _ChildrenCreatePageTwoState extends State<ChildrenCreatePageTwo> {
  late QuoteOption quoteOptionOne,
      quoteOptionTwo,
      quoteOptionThree,
      quoteOptionFour;
  var currentIndex = 0;
  final quotes = ConstantObjects.childrenCreateQuotes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Registro de hijo (paso 2 de 4) - Cuestionario'),
          ),
          const SizedBox(height: 50),
          ChildrenCreatePageTwoQuote(
            totalQuotes: quotes.length,
            model: quotes[currentIndex],
            currentOption: widget.quotesSelected[currentIndex],
            onChange: (QuoteOption? option) {
              setState(() {
                widget.quotesSelected[currentIndex] = option;
              });
            },
            onBack: () {
              if (currentIndex > 1) {
                setState(() {
                  currentIndex--;
                });
              } else {
                widget.onBack!();
              }
            },
            onContinue: () {
              if (currentIndex < quotes.length - 1) {
                setState(() {
                  currentIndex++;
                });
              } else {
                widget.onContinue!();
              }
            },
          ),
        ],
      ),
    );
  }
}
