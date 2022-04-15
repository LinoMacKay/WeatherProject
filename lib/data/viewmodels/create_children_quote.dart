class CreateChildrenQuoteViewmodel {
  final int quoteNumber;
  final String quote;
  final List<QuoteOption> quoteOptions;

  CreateChildrenQuoteViewmodel({
    required this.quote,
    required this.quoteNumber,
    required this.quoteOptions,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreateChildrenQuoteViewmodel &&
            quoteNumber == other.quoteNumber &&
            quote == other.quote &&
            quoteOptions == other.quoteOptions;
  }

  factory CreateChildrenQuoteViewmodel.fromJson(
      Map<String, dynamic> questionJson, answerJson) {
    var id = questionJson['id'];
    var question = questionJson['question'];
    Iterable l = answerJson;

    List<QuoteOption> possibleAnswers =
        List<QuoteOption>.from(l.map((model) => QuoteOption.fromJson(model)));

    return CreateChildrenQuoteViewmodel(
        quote: question, quoteNumber: id, quoteOptions: possibleAnswers);
  }
}

class QuoteOption {
  final String id, description;
  int point;

  QuoteOption({required this.id, this.description = '', this.point = 0});

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is QuoteOption &&
            id == other.id &&
            description == other.description;
  }

  QuoteOption.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        description = json['description'],
        point = json['point'];
}
