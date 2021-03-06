import 'package:flutter/material.dart';
import 'package:my_project/core/bloc/createChildBloc.dart';
import 'package:my_project/data/viewmodels/create_children_quote.dart';
import 'package:my_project/data/viewmodels/fototipo_option.dart';
import 'package:my_project/helper/ui/ui_library.dart';
import 'package:my_project/views/children/create/pages/page_four/children_create_page_four.dart';
import 'package:my_project/views/children/create/pages/page_one/children_create_page_one.dart';
import 'package:my_project/views/children/create/pages/page_one/children_create_page_one_form.dart';
import 'package:my_project/views/children/create/pages/page_three/children_create_page_three.dart';
import 'package:my_project/views/children/create/pages/page_two/children_create_page_two.dart';

class ChildrenCreateView extends StatefulWidget {
  const ChildrenCreateView({Key? key}) : super(key: key);

  @override
  _ChildrenCreateViewState createState() => _ChildrenCreateViewState();
}

class _ChildrenCreateViewState extends State<ChildrenCreateView> {
  final pageOneForm = ChildrenCreatePageOneForm();
  CreateChildBloc createChildBloc = CreateChildBloc();
  var _currentPageIndex = 0;
  final quotesSelected = <QuoteOption?>[
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null
  ]; // añadi mas nulls porque aumenté la lista de preguntas
  final fototipoOptionViewmodel = FototipoOptionViewmodel();

  Widget _currentPage(int index) {
    switch (index) {
      case 0:
        return ChildrenCreatePageOne(
          form: pageOneForm,
          bloc: createChildBloc,
          onContinue: () => setState(() {
            _currentPageIndex++;
          }),
        );
      case 1:
        return ChildrenCreatePageTwo(
          quotesSelected: quotesSelected,
          form: pageOneForm,
          onContinue: () {
            setState(() {
              _currentPageIndex++;
            });
          },
          onBack: () => setState(() {
            _currentPageIndex--;
          }),
        );
      case 2:
        return ChildrenCreatePageFour(
          fototipoOptionViewmodel: fototipoOptionViewmodel,
          selectedOptions: quotesSelected,
          form: pageOneForm,
          onContinue: () {
            setState(() {
              _currentPageIndex++;
            });
          },
          onBack: () => setState(() {
            _currentPageIndex--;
          }),
        );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: _currentPage(_currentPageIndex),
        ),
      ),
    );
  }
}
