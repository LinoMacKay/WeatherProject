import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:my_project/core/bloc/questionBloc.dart';
import 'package:my_project/data/viewmodels/create_children_quote.dart';
import 'package:my_project/helper/constants/objects.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/router/routes.dart';
import 'package:my_project/utils/Utils.dart';
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
  List<CreateChildrenQuoteViewmodel> quotes = [];
  QuestionBloc questionBloc = QuestionBloc();
  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(myInterceptor);
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return true;
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  late QuoteOption quoteOptionOne,
      quoteOptionTwo,
      quoteOptionThree,
      quoteOptionFour;
  var currentIndex = 0;
  int totalPoints = 0;

  Function onContinue(List<CreateChildrenQuoteViewmodel> responseQuotes) {
    return () {
      if (currentIndex < responseQuotes.length - 1) {
        setState(() {
          currentIndex++;
        });
      } else {
        widget.onContinue!();
      }
    };
  }

  Function onBack() {
    return () {
      if (currentIndex >= 1) {
        setState(() {
          currentIndex--;
        });
      } else {
        widget.onBack!();
      }
    };
  }

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
          FutureBuilder<Object>(
              future: questionBloc.getQuestions(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var responseQuotes =
                      snapshot.data as List<CreateChildrenQuoteViewmodel>;
                  return ChildrenCreatePageTwoQuote(
                    totalQuotes: responseQuotes.length,
                    model: responseQuotes[currentIndex],
                    currentOption: widget.quotesSelected[currentIndex],
                    onChange: (QuoteOption? option) {
                      setState(() {
                        widget.quotesSelected[currentIndex] = option;
                      });
                    },
                    onBack: onBack(),
                    onContinue: onContinue(responseQuotes),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
          const SizedBox(height: 50),
          ElevatedButton(
              onPressed: () {
                Utils.homeNavigator.currentState!.pushNamed(routeChildrenPhoto);
              },
              child: Text("Registrar con foto"),
              style: ElevatedButton.styleFrom(primary: Colors.red))
        ],
      ),
    );
  }
}
