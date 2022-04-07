import 'package:my_project/data/viewmodels/create_children_quote.dart';
import 'package:my_project/data/viewmodels/fototipo_option.dart';

class ConstantObjects {
  static final childrenCreateQuotes =
      <CreateChildrenQuoteViewmodel>[
    CreateChildrenQuoteViewmodel(
      quoteNumber: 0,
      quote:
          '¿Cuál es el color natural de la piel de su hijo cuando no está bronceada?',
      quoteOptions: <QuoteOption>[
        QuoteOption(
          id: '0',
          description: 'Rojiza, blanca',
        ),
        QuoteOption(
          id: '1',
          description: 'Blanca-beige',
        ),
        QuoteOption(
          id: '2',
          description: 'Beige',
        ),
        QuoteOption(
          id: '3',
          description: 'Marrón clara',
        ),
        QuoteOption(
          id: '4',
          description: 'Marrón',
        ),
        QuoteOption(
          id: '5',
          description: 'Negra',
        ),
      ],
    ),
    CreateChildrenQuoteViewmodel(
      quoteNumber: 1,
      quote: '¿De qué color natural  es el cabello de su hijo?',
      quoteOptions: <QuoteOption>[
        QuoteOption(
          id: '0',
          description: 'Pelirrojo, rubio claro',
        ),
        QuoteOption(
          id: '1',
          description: 'Castaño',
        ),
        QuoteOption(
          id: '2',
          description: 'Castaño oscuro',
        ),
        QuoteOption(
          id: '3',
          description: 'Rubio, castaño claro',
        ),
        QuoteOption(
          id: '4',
          description: 'Castaño oscuro-negro',
        ),
        QuoteOption(
          id: '5',
          description: 'Negro',
        ),
      ],
    ),
    CreateChildrenQuoteViewmodel(
      quoteNumber: 2,
      quote:
          '¿Cuántas pecas tiene de manera natural su hijo en el cuerpo cuando no está bronceado?',
      quoteOptions: <QuoteOption>[
        QuoteOption(
          id: '0',
          description: 'Muchas',
        ),
        QuoteOption(
          id: '1',
          description: 'Algunas',
        ),
        QuoteOption(
          id: '2',
          description: 'Unas cuantas',
        ),
        QuoteOption(
          id: '3',
          description: 'Ninguna',
        ),
      ],
    ),
    CreateChildrenQuoteViewmodel(
      quoteNumber: 3,
      quote:
          '¿Qué categoría describe mejor el potencial de quemadura de su hijo después de exponerse al sol una hora en verano?',
      quoteOptions: <QuoteOption>[
        QuoteOption(
          id: '0',
          description:
              'Siempre se quema a veces, pero se broncea moderadamente',
        ),
        QuoteOption(
          id: '1',
          description: 'Siempre se quema y no se broncea nunca',
        ),
        QuoteOption(
          id: '2',
          description: 'Nunca de quema y se broncea con facilidad',
        ),
        QuoteOption(
          id: '3',
          description: 'Nunca se quema',
        ),
      ],
    ),
  ];

  static final fototipos = <FototipoOptionViewmodel>[
    FototipoOptionViewmodel(
      name: 'Light, pale white',
    ),
    FototipoOptionViewmodel(
      name: 'White, fair',
    ),
    FototipoOptionViewmodel(
      name: 'Medium white to alive',
    ),
    FototipoOptionViewmodel(
      name: 'Olive, mid brown',
    ),
    FototipoOptionViewmodel(
      name: 'Brown, dark brown',
    ),
    FototipoOptionViewmodel(
      name: 'Very dark brown, black',
    ),
  ];
}
