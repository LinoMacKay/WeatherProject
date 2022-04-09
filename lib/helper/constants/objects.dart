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
    // a partir de aca agregé preguntas
    CreateChildrenQuoteViewmodel(
          quoteNumber: 4,
          quote:
          '¿Cual es el color de los ojos de sus hijos?',
          quoteOptions: <QuoteOption>[
            QuoteOption(
              id: '0',
              description:
              'Azul claro-verde',
            ),
            QuoteOption(
              id: '1',
              description: 'Azul, verde, gris',
            ),
            QuoteOption(
              id: '2',
              description: 'Azul oscuro-verde, marrón claro (avellana)',
            ),
            QuoteOption(
              id: '3',
              description: 'Marrón oscuro',
            ),
            QuoteOption(
              id: '4',
              description: 'Negro parduzco',
            ),
          ],
        ),
    CreateChildrenQuoteViewmodel(
          quoteNumber: 5,
          quote:
          '¿Con qué frecuencia la piel su hijo se broncea después exponerse al sol?',
          quoteOptions: <QuoteOption>[
            QuoteOption(
              id: '0',
              description:
              'Nunca',
            ),
            QuoteOption(
              id: '1',
              description: 'Casi nunca',
            ),
            QuoteOption(
              id: '2',
              description: 'A veces',
            ),
            QuoteOption(
              id: '3',
              description: 'Muy seguido',
            ),
            QuoteOption(
              id: '4',
              description: 'Siempre',
            ),
          ],
        ),
    CreateChildrenQuoteViewmodel(
          quoteNumber: 6,
          quote:
          '¿En qué intensidad la piel de su hijo se broncea después de la exposición al sol?',
          quoteOptions: <QuoteOption>[
            QuoteOption(
              id: '0',
              description:
              'Poco o nada',
            ),
            QuoteOption(
              id: '1',
              description: 'Bronceado suave',
            ),
            QuoteOption(
              id: '2',
              description: 'Bronceado medio',
            ),
            QuoteOption(
              id: '3',
              description: 'Bronceado oscuro',
            ),
            QuoteOption(
              id: '4',
              description: 'Bronceado muy oscuro',
            ),
          ],
        ),
    CreateChildrenQuoteViewmodel(
          quoteNumber: 7,
          quote:
          '¿Qué categoría describe mejor la sensibilidd de la cara de su hijo al sol?',
          quoteOptions: <QuoteOption>[
            QuoteOption(
              id: '0',
              description:
              'Muy sensible',
            ),
            QuoteOption(
              id: '1',
              description: 'Sensible',
            ),
            QuoteOption(
              id: '2',
              description: 'Levemente Sensible',
            ),
            QuoteOption(
              id: '3',
              description: 'Resistente',
            ),
            QuoteOption(
              id: '4',
              description: 'Muy resistente',
            ),
          ],
        ),
    CreateChildrenQuoteViewmodel(
          quoteNumber: 8,
          quote:
          '¿Con qué frecuencia su hijo se broncea voluntariamente(bronceadores, sprays, etc)?',
          quoteOptions: <QuoteOption>[
            QuoteOption(
              id: '0',
              description:
              'Nunca',
            ),
            QuoteOption(
              id: '1',
              description: 'Casi nunca',
            ),
            QuoteOption(
              id: '2',
              description: 'A veces',
            ),
            QuoteOption(
              id: '3',
              description: 'Muy seguido',
            ),
            QuoteOption(
              id: '4',
              description: 'Siempre',
            ),
          ],
        ),
    CreateChildrenQuoteViewmodel(
          quoteNumber: 9,
          quote:
          '¿Cuándo fue la última vez que la piel de su hijo se expuso al sol o a fuentes de bronceado tradicional(camas de bronceado, etc)?',
          quoteOptions: <QuoteOption>[
            QuoteOption(
              id: '0',
              description:
              'Hace más de 3 meses',
            ),
            QuoteOption(
              id: '1',
              description: 'En los últimos 2-3 meses',
            ),
            QuoteOption(
              id: '2',
              description: 'En los últimos 1-2 meses',
            ),
            QuoteOption(
              id: '3',
              description: 'La semana pasada',
            ),
            QuoteOption(
              id: '4',
              description: 'Ayer',
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
