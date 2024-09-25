import 'package:flutter/material.dart';

import 'package:random_name_generator/random_name_generator.dart';

class PeopleList extends StatefulWidget {
  final Zone zone;

  const PeopleList({super.key, required this.zone});

  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  final _suggestions = <String>[];
  final _suggestionsTextStyle = const TextStyle(fontSize: 18);
  late RandomNames _randomNames;

  @override
  void initState() {
    super.initState();
    _randomNames = RandomNames(widget.zone);
  }

  @override
  void didUpdateWidget(PeopleList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Torna a generar la llista quan canvïa la zona
    if (oldWidget.zone.id != widget.zone.id) {
      _randomNames = RandomNames(widget.zone);
      _suggestions.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, i) {
        if (i >= _suggestions.length) {
          // Genera tants noms com sigui necessari
          for (int j = _suggestions.length; i >= j; j++) {
            _suggestions.add(_randomNames.fullName());
          }
        }
        return Column(
          children: [
            ListTile(
              title: Text(
                _suggestions[i],
                style: _suggestionsTextStyle,
              ),
            ),
            const Divider(),
          ],
        );
      },
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
