import 'package:random_name_generator/random_name_generator.dart';

extension ZoneExtension on Zone {
  static const zoneIdToName = {
    'afghanistan': 'Afganistan',
    'austria': 'Àustria',
    'belgium': 'Bèlgica',
    'brazil': 'Brasil',
    'canada': 'Canadà',
    'catalonia': 'Catalunya',
    'china': 'Xina',
    'egypt': 'Egipte',
    'finland': 'Finlàndia',
    'france': 'França',
    'germany': 'Alemanya',
    'india': 'Índia',
    'iran': 'Iran',
    'italy': 'Itàlia',
    'japan': 'Japó',
    'poland': 'Polònia',
    'romania': 'Romania',
    'saudi_arabia': 'Aràbia Saudita',
    'south_africa': 'Sud-àfrica',
    'spain': 'Espanya',
    'switzerland': 'Suïssa',
    'turkey': 'Turquia',
    'uganda': 'Uganda',
    'uk': 'Regne Unit',
    'ukraine': 'Ucraïna',
    'us': 'Estats Units',
    'zimbabwe': 'Zimbàbue',
  };

  String get name => zoneIdToName[id] ?? id;
}
