import 'dart:convert';

import 'package:my_project/data/viewmodels/create_children_quote.dart';
import 'package:http/http.dart' as http;

class QuestionProvider {
  Future<List<CreateChildrenQuoteViewmodel>> getQuestions() async {
    String url = 'https://uvbackend.azurewebsites.net/Profile/GetQuestionary';
    Uri uri = Uri.parse(url);

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> jsonresponse = json.decode(response.body);
      List<CreateChildrenQuoteViewmodel> questions = [];
      jsonresponse.forEach((element) {
        var test = CreateChildrenQuoteViewmodel.fromJson(
            element['question'], element['possibleAnswers']);
        questions.add(test);
      });

      return questions;
    } else {
      return Future.error("Internal Server Error");
    }
  }
}
