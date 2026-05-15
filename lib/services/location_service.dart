import 'package:geolocator/geolocator.dart';
import '../models/silent_zone.dart';
import 'sound_service.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  final SoundService _soundService = SoundService();
  List<SilentZone> _silentZones = [];
  bool _isInSilentZone = false;

  Future<bool> requestPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.whileInUse || permission == LocationPermission.always;
  }

  Future<Position?> getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return null;
    }
  }

  void updateSilentZones(List<SilentZone> zones) {
    _silentZones = zones;
  }

  Future<void> checkZones() async {
    final position = await getCurrentLocation();
    if (position == null) return;

    bool inAnyZone = false;
    String? zoneSoundMode;
    
    for (final zone in _silentZones.where((z) => z.isActive)) {
      final distance = Geolocator.distanceBetween(
        position.latitude, position.longitude,
        zone.latitude, zone.longitude,
      );
      
      if (distance <= zone.radius) {
        inAnyZone = true;
        zoneSoundMode = zone.soundMode;
        break;
      }
    }

    if (inAnyZone != _isInSilentZone) {
      _isInSilentZone = inAnyZone;
      if (inAnyZone && zoneSoundMode != null) {
        await _soundService.setSoundMode(zoneSoundMode);
      } else {
        await _soundService.setSoundMode('normal');
      }
    }
  }

  bool get isInSilentZone => _isInSilentZone;

  void dispose() {
    // Cleanup if needed
  }
}