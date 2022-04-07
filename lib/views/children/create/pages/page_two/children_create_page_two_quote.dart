import 'package:flutter/material.dart';
import 'package:my_project/data/viewmodels/create_children_quote.dart';
import 'package:my_project/helper/ui/ui_library.dart';

class ChildrenCreatePageTwoQuote extends StatelessWidget {
  final int totalQuotes;
  final CreateChildrenQuoteViewmodel model;
  final Function(QuoteOption?)? onChange;
  final QuoteOption? currentOption;
  final VoidCallback? onBack, onContinue;
  const ChildrenCreatePageTwoQuote({
    Key? key,
    this.totalQuotes = 0,
    this.currentOption,
    this.onBack,
    this.onContinue,
    this.onChange,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Pregunta ${model.quoteNumber + 1} de $totalQuotes'),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${model.quoteNumber + 1}. ${model.quote}'),
                Container(
                  height: 60,
                  alignment: Alignment.topCenter,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<QuoteOption>(
                      items: model.quoteOptions
                          .map((QuoteOption option) =>
                          DropdownMenuItem<QuoteOption>(
                            child: Center(
                              child: Text(
                                option.description,
                              ),
                            ),
                            value: option,
                          ))
                          .toList(),
                      isExpanded: true,
                      iconSize: 20,
                      hint: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Seleccione su respuesta',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      value: currentOption,
                      onChanged: onChange,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    AppButton(
                      onPressed: onBack,
                      text: 'Regresar',
                      width: 100,
                    ),
                    AppButton(
                      onPressed: onContinue,
                      text: 'Continuar',
                      width: 100,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
