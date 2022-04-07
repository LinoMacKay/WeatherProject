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
}

class QuoteOption {
  final String id, description;

  QuoteOption({required this.id, this.description = ''});

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is QuoteOption &&
            id == other.id &&
            description == other.description;
  }
}