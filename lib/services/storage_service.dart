import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/silent_zone.dart';

class StorageService {
  static const String _zonesKey = 'silent_zones';

  Future<List<SilentZone>> loadZones() async {
    final prefs = await SharedPreferences.getInstance();
    final zonesJson = prefs.getStringList(_zonesKey) ?? [];
    return zonesJson.map((json) => SilentZone.fromJson(jsonDecode(json))).toList();
  }

  Future<void> saveZones(List<SilentZone> zones) async {
    final prefs = await SharedPreferences.getInstance();
    final zonesJson = zones.map((zone) => jsonEncode(zone.toJson())).toList();
    await prefs.setStringList(_zonesKey, zonesJson);
  }

  Future<void> addZone(SilentZone zone) async {
    final zones = await loadZones();
    zones.add(zone);
    await saveZones(zones);
  }

  Future<void> removeZone(String zoneId) async {
    final zones = await loadZones();
    zones.removeWhere((zone) => zone.id == zoneId);
    await saveZones(zones);
  }
}