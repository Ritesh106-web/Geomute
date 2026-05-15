import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

class SoundService {
  static final SoundService _instance = SoundService._internal();
  factory SoundService() => _instance;
  SoundService._internal();

  static const platform = MethodChannel('com.example.geomute/sound');

  Future<void> setSilentMode(bool silent) async {
    await setSoundMode(silent ? 'silent' : 'normal');
  }

  Future<void> setSoundMode(String mode) async {
    if (kIsWeb) return;
    try {
      final bool hasPermission = await platform.invokeMethod('hasPermission');
      if (!hasPermission) {
        print('Requesting DND permission...');
        await platform.invokeMethod('requestPermission');
        return;
      }
      
      final bool success = await platform.invokeMethod('setSoundMode', {'mode': mode});
      if (success) {
        print('Sound mode changed to: $mode');
      } else {
        print('Failed to change sound mode');
      }
    } catch (e) {
      print('Error setting sound mode: $e');
    }
  }

  Future<String> getCurrentSoundMode() async {
    if (kIsWeb) return 'normal';
    try {
      final String mode = await platform.invokeMethod('getCurrentMode');
      return mode;
    } catch (e) {
      print('Error getting sound mode: $e');
      return 'normal';
    }
  }

  Future<bool> isSilent() async {
    final mode = await getCurrentSoundMode();
    return mode == 'silent';
  }
}