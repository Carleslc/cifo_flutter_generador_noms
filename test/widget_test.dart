import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:generador_noms/main.dart';
import 'package:generador_noms/widgets/zone_selector.dart';

import 'package:material_symbols_icons/symbols.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    // Mock shared preferences
    SharedPreferences.setMockInitialValues({});
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  testWidgets('Generador de noms test', (WidgetTester tester) async {
    // Carrega l'aplicació a testejar
    await tester.pumpWidget(const NameGeneratorApp());
    await tester.pumpAndSettle();

    // Verifica que existeix la llista amb un ListView i widgets ListTile
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ListTile), findsWidgets);

    final initialItems = tester.widgetList(find.byType(ListTile)).length;

    // Desplaça la llista i comprova que s'afegeixen nous noms
    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();

    final newItems = tester.widgetList(find.byType(ListTile)).length;
    expect(newItems, greaterThan(initialItems));

    // Agafa els noms abans de canviar la zona
    List<String> namesBefore =
        tester.widgetList(find.byType(ListTile)).map((widget) {
      final listTile = widget as ListTile;
      final textWidget = listTile.title as Text;
      return textWidget.data ?? '';
    }).toList();

    // Verifica que "Catalunya" es la zona seleccionada per defecte al selector de zona
    expect(
      find.descendant(
        of: find.byType(ZoneSelector),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is EditableText && widget.controller.text == 'Catalunya',
        ),
      ),
      findsOneWidget,
    );

    // Pulsa el selector de zona per obrir el desplegable
    await tester.tap(find.byIcon(Symbols.globe).first);
    await tester.pumpAndSettle(); // espera a que l'animació del dropdown acabi

    // Verifica que les zones es mostren al selector
    const selectZoneName = 'França';
    final selectZone = find.text(selectZoneName);

    expect(selectZone, findsAny);

    // Selecciona la nova zona
    await tester.ensureVisible(selectZone.last);
    await tester.tap(selectZone.last);
    await tester.pumpAndSettle();

    // Verifica que el selector de zona mostra la nova zona
    expect(
      find.descendant(
        of: find.byType(ZoneSelector),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is EditableText &&
              widget.controller.text == selectZoneName,
        ),
      ),
      findsOneWidget,
    );

    // Agafa els nous noms després de canviar la zona
    List<String> namesAfter =
        tester.widgetList(find.byType(ListTile)).map((widget) {
      final listTile = widget as ListTile;
      final textWidget = listTile.title as Text;
      return textWidget.data ?? '';
    }).toList();

    // Verifica que la llista de noms s'ha modificat
    expect(namesAfter, isNot(namesBefore));
  });
}
