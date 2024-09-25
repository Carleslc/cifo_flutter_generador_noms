import 'package:shared_preferences/shared_preferences.dart';

final class Settings {
  const Settings._(); // impedeix instàncies d'aquesta clase

  static const String _zoneKey = 'zone';

  /// Carrega l'id de la zona guardat a les preferències
  static Future<String?> getZoneId() async {
    final settings = SharedPreferencesAsync();

    final String? zoneId = await settings.getString(_zoneKey);

    return zoneId;
  }

  /// Guarda l'id de la zona a les preferències
  static Future<void> setZoneId(String zoneId) async {
    final settings = SharedPreferencesAsync();

    await settings.setString(_zoneKey, zoneId);
  }
}
