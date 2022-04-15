import 'package:my_project/core/provider/questionsProvider.dart';
import 'package:my_project/data/viewmodels/create_children_quote.dart';

class QuestionBloc {
  QuestionProvider questionProvider = QuestionProvider();

  Future<List<CreateChildrenQuoteViewmodel>> getQuestions() async {
    var questions = await questionProvider.getQuestions();

    return questions;
  }
}
