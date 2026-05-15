# GeoMute

A Flutter application that automatically switches your phone to silent mode when entering specific geolocations and back to normal mode when leaving.

## Features

- **Automatic Sound Control**: Switches phone to silent/normal mode based on location
- **Multiple Silent Zones**: Create and manage multiple geofenced areas
- **Background Tracking**: Continuously monitors location in the background
- **Modern UI**: Clean interface with Google Maps integration
- **Local Storage**: Saves zones locally using SharedPreferences
- **Cloud Sync**: Optional AWS Amplify integration for data synchronization

## Setup Instructions

### 1. Dependencies
Run `flutter pub get` to install all required packages.

### 2. Google Maps API
1. Get a Google Maps API key from Google Cloud Console
2. Replace `YOUR_GOOGLE_MAPS_API_KEY` in `android/app/src/main/AndroidManifest.xml`

### 3. Permissions
The app requires the following permissions:
- Location (fine and coarse)
- Background location access
- Audio settings modification
- Notification policy access

### 4. AWS Amplify (Optional)
To enable cloud sync:
1. Set up AWS Amplify project
2. Configure authentication and DataStore
3. Update `AmplifyService` with your configuration

## Usage

1. **Grant Permissions**: Allow location and audio permissions when prompted
2. **Add Silent Zone**: Tap the + button to open the map and select a location
3. **Configure Zone**: Set name and radius for the silent zone
4. **Automatic Operation**: The app will monitor your location and switch sound modes automatically

## Key Components

- **LocationService**: Handles geofencing and location tracking
- **SoundService**: Manages phone sound mode changes
- **StorageService**: Local data persistence
- **AmplifyService**: Cloud synchronization (optional)

## Technical Details

- **Geofencing**: Uses `geofence_service` for background location monitoring
- **Sound Control**: Uses `sound_mode` package for ringer mode management
- **Maps**: Google Maps Flutter plugin for zone selection
- **Storage**: SharedPreferences for local data storage
- **Background**: Foreground service for continuous monitoring

## Build and Run

```bash
flutter pub get
flutter run
```

For release build:
```bash
flutter build apk --release
```