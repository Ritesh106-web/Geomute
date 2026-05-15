# Changelog

All notable changes to GeoMute will be documented here.

## [1.0.0] - 2025-01-01

### Added
- Initial release of GeoMute
- Geofencing-based automatic sound profile switching
- Google Maps integration for zone selection
- Multiple silent zone management (add/delete)
- Silent, Vibrate, and Normal mode support
- Background location monitoring via Android WorkManager
- Foreground monitoring every 5 seconds
- Local data persistence using SharedPreferences
- Material Design UI with gradient app bar
- Location search functionality
- Custom app logo and launcher icons
- About screen with project information
- Native Android sound control via Kotlin MethodChannel
- Do Not Disturb permission handling

### Fixed
- App crash on launch due to background service initialization
- Sound mode not changing due to missing DND permission request
- Duplicate service declaration in AndroidManifest

## [0.1.0] - 2024-12-01

### Added
- Initial project setup
- Basic Flutter project structure
- Core services: LocationService, SoundService, StorageService
