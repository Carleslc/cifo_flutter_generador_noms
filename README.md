# Generador de noms

**Repositori d'aplicacions: [cifo_flutter](https://github.com/Carleslc/cifo_flutter)**

<!-- toc -->

- [Instal·lació](#instal%C2%B7lacio)
- [Estructura de l'aplicació](#estructura-de-laplicacio)
- [Notes del desenvolupament](#notes-del-desenvolupament)
- [Imatges](#imatges)
- [Recursos](#recursos)
- [Llibreries externes](#llibreries-externes)

<!-- tocstop -->

## Activitat d'aprenentatge 1.2 - Escriu la teva primera App en Flutter

Aplicació per generar noms de persones a l'atzar.

Els noms es generen en una llista infinita, quan es desplaça la llista es generen noms nous.

Es pot seleccionar la zona d'on es volen generar els noms.

S'utilitzen components de [Material Design 3](https://m3.material.io/).

<a href="https://idx.google.com/import?url=https%3A%2F%2Fgithub.com%2FCarleslc%2Fcifo_flutter_generador_noms%2F" target="_blank">
  <picture>
    <source
      media="(prefers-color-scheme: dark)"
      srcset="https://cdn.idx.dev/btn/open_dark_32.svg">
    <source
      media="(prefers-color-scheme: light)"
      srcset="https://cdn.idx.dev/btn/open_light_32.svg">
    <img
      height="32"
      alt="Open in IDX"
      src="https://cdn.idx.dev/btn/open_purple_32.svg">
  </picture>
</a>

## Instal·lació

1. S'ha d'haver instal·lat el [Flutter SDK](https://docs.flutter.dev/get-started/install).

2. Clonar el repositori:

```sh
git clone https://github.com/Carleslc/cifo_flutter_generador_noms.git
# GitHub CLI: gh repo clone Carleslc/cifo_flutter_generador_noms

cd cifo_flutter_generador_noms
```

3. Instal·lar les dependències:

```sh
flutter pub get
```

4. Executar l'aplicació amb `flutter run` o desde l'IDE.

## Estructura de l'aplicació

```
lib
├── extensions
│   └── zone_extension.dart
├── main.dart
├── screens
│   └── people_list.dart
├── settings.dart
└── widgets
    └── zone_selector.dart
```

S'ha organitzat el codi afegint la carpeta `screens` amb el fitxer `people_list.dart` que conté el widget `PeopleList` amb la llista de noms, una carpeta `widgets` per altres widgets propis com el selector de zona `ZoneSelector` al fitxer `zone_selector.dart` i una carpeta `extensions` per utilitats com la extensió `zone_extension.dart` que extén la clase `Zone` per afegir un getter `name` que tradueix l'id de la zona al seu nom en català.

Al fitxer `main.dart` es crea el layout principal de l'aplicació i es gestiona la zona que es passa al `ZoneSelector` i `PeopleList`.

El fitxer `settings.dart` és una classe amb mètodes estàtics per gestionar el guardat de la zona amb [`shared_preferences`](https://pub.dev/packages/shared_preferences).

## Notes del desenvolupament

Primer vaig buscar diferents recursos per veure exemples de widgets i la documentació dels [widgets Material](https://docs.flutter.dev/ui/widgets/material).

Per començar l'aplicació he seguit el pdf [Activitat d'aprenentatge 1.2 - Escriu la teva primera app amb Flutter](<./Activitat daprenentatge 1.2 - Escriu la teva primera app amb Flutter.pdf>) per crear la primera versió de l'aplicació, generant noms en una llista infinita utilitzant la llibreria [`random_name_generator`](https://pub.dev/packages/random_name_generator).

Després he modificat l'estil de l'aplicació canviant colors, afegint icones, afegint una mica de padding als elements de la llista, movent el títol a un atribut de `NameGeneratorApp` a `main.dart` i canviant la zona per defecte a Catalunya.

Després he afegit les següents funcionalitats adicionals:

- Un botó que desplega un menú amb les zones disponibles per generar noms. Quan es selecciona una zona es generen noms relatius a la nova zona.
- La zona es guarda al dispositiu mitjançant la llibreria [`shared_preferences`](https://pub.dev/packages/shared_preferences), així es manté quan es tanca i es torna a obrir l'aplicació.
- S'utilitzen icones de [Material Symbols](https://fonts.google.com/icons?icon.set=Material+Symbols) utilitzant la llibreria [`material_symbols_icons`](https://pub.dev/packages/material_symbols_icons).

Per fer-ho he investigat la documentació de la llibreria [`random_name_generator`](https://pub.dev/packages/random_name_generator) i el seu codi font per veure com obtenir totes les zones programàticament amb `Zone.all`, i després altres llibreries adicionals i la documentació de Flutter per investigar els widgets necessaris com [`DropdownMenu`](https://api.flutter.dev/flutter/material/DropdownMenu-class.html), [`DropdownMenuEntry`](https://api.flutter.dev/flutter/material/DropdownMenuEntry-class.html) i altres widgets relacionats amb els estils com [`TextStyle`](https://api.flutter.dev/flutter/painting/TextStyle-class.html), [`InputDecorationTheme`](https://api.flutter.dev/flutter/material/InputDecorationTheme-class.html), [`ButtonStyle`](https://api.flutter.dev/flutter/material/ButtonStyle-class.html), [`MenuStyle`](https://api.flutter.dev/flutter/material/MenuStyle-class.html) o [`WidgetStatePropertyAll`](https://api.flutter.dev/flutter/widgets/WidgetStatePropertyAll-class.html), entre d'altres segons em requerien els tipus de paràmetres i provava coses.

També he buscat com passar la zona als widgets fills i notificar que la zona canvia utilitzant el constructor a `PeopleList` i el mètode [`didUpdateWidget`](https://api.flutter.dev/flutter/widgets/State/didUpdateWidget.html) a l'estat.

En un primer moment vaig afegir un botó [`ElevatedButton.icon`](https://api.flutter.dev/flutter/material/ElevatedButton/ElevatedButton.icon.html) a les `actions` de l'[`AppBar`](https://api.flutter.dev/flutter/material/AppBar-class.html) que canviaba a la següent zona d'entre totes les disponibles, després vaig considerar millor un desplegable per seleccionar la zona i he investigat com fer-ho utilitzant [`DropdownMenu`](https://api.flutter.dev/flutter/material/DropdownMenu-class.html), que m'ha costat d'estilitzar degut a la quantitat d'opcions disponibles. Primer vaig probar d'afegir el desplegable a l'[`AppBar`](https://api.flutter.dev/flutter/material/AppBar-class.html) i finalment l'he mogut al paràmetre [`floatingActionButton`](https://api.flutter.dev/flutter/material/Scaffold/floatingActionButton.html) de [`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html). Vaig provar de posicionar-lo prèviament amb un layout [`Stack`](https://api.flutter.dev/flutter/widgets/Stack-class.html) i [`Positioned`](https://api.flutter.dev/flutter/widgets/Positioned-class.html), però té el mateix resultat visible.

També he investigat altres widgets similars pels desplegables com [`DropdownButton`](https://api.flutter.dev/flutter/material/DropdownButton-class.html), que sembla estar en desús en favor de l'utilitzat [`DropdownMenu`](https://api.flutter.dev/flutter/material/DropdownMenu-class.html) per Material 3, i [`MenuAnchor`](https://api.flutter.dev/flutter/material/MenuAnchor-class.html) que finalment no he utilitzat.

He afegit un [`Tooltip`](https://api.flutter.dev/flutter/material/Tooltip-class.html) amb un missatge d'ajuda pel desplegable, però només és visible al web.

Finalment he investigat una mica com [testejar](https://docs.flutter.dev/testing/overview) l'aplicació amb Flutter i he modificat el test per defecte `test/widget_test.dart` per provar la llista i el desplegable.

He utilitzat l'IDE web [Project IDX](https://idx.google.com/) durant tot el desenvolupament per provar com funciona. Va prou bé, amb un emulador d'Android amb versió 10 i provant-ho al web també, però no em deixava obrir els _Flutter DevTools_ i a vegades se'm reiniciava l'entorn, però l'execució de l'aplicació i l'emulador em va més ràpid a IDX que al meu ordinador, així que potser continuo utilitzant-lo si ho veig convenient.

Després he continuat el desenvolupament en local amb _Visual Studio Code_ per poder provar l'aplicació amb un emulador en local i amb un mòvil físic, i finalment he creat aquest repositori git per pujar el codi.

## Imatges

![generador_noms_1.png](<./images/generador_noms_1.png>)

![generador_noms_2.png](<./images/generador_noms_2.png>)

## Recursos

- [Material Design 3](https://m3.material.io/)
- [Material Widgets](https://docs.flutter.dev/ui/widgets/material)
- [API Docs: `DropdownMenu`](https://api.flutter.dev/flutter/material/DropdownMenu-class.html)

### Llibreries externes

- [`random_name_generator`](https://pub.dev/packages/random_name_generator)
- [`material_symbols_icons`](https://pub.dev/packages/material_symbols_icons)
- [`shared_preferences`](https://pub.dev/packages/shared_preferences)
