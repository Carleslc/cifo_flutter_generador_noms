import 'package:flutter/material.dart';

import 'package:material_symbols_icons/symbols.dart';
import 'package:random_name_generator/random_name_generator.dart';

import '../extensions/zone_extension.dart';

class ZoneSelector extends StatelessWidget {
  final Zone? initialZone;
  final List<Zone> availableZones;
  final ValueChanged<Zone?> onSelected;

  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? menuBackgroundColor;

  const ZoneSelector({
    super.key,
    this.initialZone,
    required this.availableZones,
    required this.onSelected,
    this.foregroundColor,
    this.backgroundColor,
    this.menuBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Selecciona la zona',
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownMenu<Zone>(
        initialSelection: initialZone,
        onSelected: onSelected,
        // Opcions
        dropdownMenuEntries: availableZones.map((Zone zone) {
          return DropdownMenuEntry<Zone>(
            value: zone,
            label: zone.name,
            // Estils de cada opció dins del desplegable
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(foregroundColor),
              textStyle: const WidgetStatePropertyAll(TextStyle(fontSize: 16)),
              padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 16)),
            ),
          );
        }).toList(),
        // Estils del valor seleccionat
        textStyle: TextStyle(color: foregroundColor, fontSize: 18),
        // Icones del botó
        trailingIcon: Icon(Symbols.globe, color: foregroundColor),
        selectedTrailingIcon: Icon(Icons.arrow_drop_up, color: foregroundColor),
        // Estils del botó
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: backgroundColor,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        // Estils del desplegable
        menuStyle: MenuStyle(
          backgroundColor:
              WidgetStatePropertyAll(menuBackgroundColor ?? backgroundColor),
          maximumSize: const WidgetStatePropertyAll(Size.fromHeight(400)),
        ),
      ),
    );
  }
}
