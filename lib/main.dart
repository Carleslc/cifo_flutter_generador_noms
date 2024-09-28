import 'package:flutter/material.dart';

import 'package:material_symbols_icons/symbols.dart';
import 'package:random_name_generator/random_name_generator.dart';

import 'settings.dart';
import 'screens/people_list.dart';
import 'widgets/zone_selector.dart';

void main() {
  runApp(const NameGeneratorApp());
}

class NameGeneratorApp extends StatefulWidget {
  final String title = 'Generador de noms';

  const NameGeneratorApp({super.key});

  @override
  State<NameGeneratorApp> createState() => _NameGeneratorAppState();
}

class _NameGeneratorAppState extends State<NameGeneratorApp> {
  Zone _zone = Zone.all.first;

  @override
  void initState() {
    super.initState();
    _setInitialZone();
  }

  void _setInitialZone() async {
    // Carrega la zona guardada
    final String? zoneId = await Settings.getZoneId();

    // Assigna la zona corresponent
    if (zoneId != null) {
      setState(() {
        _zone = Zone.all.firstWhere((zone) => zone.id == zoneId);
      });
    }
    debugPrint('Initial Zone: ${_zone.id}');
  }

  void _setZone(Zone? zone) {
    if (zone != null && zone.id != _zone.id) {
      // Canvia la zona
      setState(() {
        _zone = zone;
      });

      // Guarda la zona seleccionada
      Settings.setZoneId(zone.id).whenComplete(() {
        debugPrint('Set Zone: ${zone.id}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: false,
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          leading: const Icon(Symbols.id_card, fill: 1, size: 30),
        ),
        floatingActionButton: ZoneSelector(
          initialZone: _zone,
          availableZones: Zone.all,
          onSelected: _setZone,
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurple,
          menuBackgroundColor: Colors.deepPurple[400],
        ),
        body: PeopleList(zone: _zone),
      ),
    );
  }
}
