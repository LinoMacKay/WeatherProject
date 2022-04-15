import 'package:flutter/material.dart';
import 'package:my_project/data/viewmodels/create_children_quote.dart';
import 'package:my_project/helper/ui/ui_library.dart';

class ChildrenCreatePageTwoQuote extends StatefulWidget {
  final int totalQuotes;
  final CreateChildrenQuoteViewmodel model;
  final Function(QuoteOption?)? onChange;
  final QuoteOption? currentOption;
  final Function? onBack, onContinue;
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
  State<ChildrenCreatePageTwoQuote> createState() =>
      _ChildrenCreatePageTwoQuoteState();
}

class _ChildrenCreatePageTwoQuoteState
    extends State<ChildrenCreatePageTwoQuote> {
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
          Text('Pregunta ${widget.model.quoteNumber} de ${widget.totalQuotes}'),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${widget.model.quoteNumber}. ${widget.model.quote}'),
                Container(
                  height: 60,
                  alignment: Alignment.topCenter,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<QuoteOption>(
                      items: widget.model.quoteOptions
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
                      value: widget.currentOption,
                      onChanged: widget.onChange,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingActionButton(
                        backgroundColor: Colors.red,
                        child: Icon(Icons.arrow_back),
                        onPressed: () {
                          widget.onBack!();
                        }),
                    if (widget.currentOption != null &&
                        widget.currentOption!.description.length > 0)
                      FloatingActionButton(
                          backgroundColor: Colors.red,
                          child: Icon(Icons.arrow_forward),
                          onPressed: () {
                            widget.onContinue!();
                          }),
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
