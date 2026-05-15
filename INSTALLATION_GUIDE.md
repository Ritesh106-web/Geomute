# GeoMute - Installation and Setup Guide

## Prerequisites

### 1. Install Flutter SDK
1. Download Flutter SDK from: https://flutter.dev/docs/get-started/install
2. Extract to a location (e.g., C:\flutter)
3. Add Flutter to PATH:
   - Windows: Add `C:\flutter\bin` to System Environment Variables
   - Verify: Open CMD and run `flutter --version`

### 2. Install Android Studio
1. Download from: https://developer.android.com/studio
2. Install Android Studio
3. Open Android Studio → SDK Manager
4. Install:
   - Android SDK Platform (API 26 or higher)
   - Android SDK Build-Tools
   - Android Emulator

### 3. Install Git
1. Download from: https://git-scm.com/downloads
2. Install with default settings

## Setup Steps

### Step 1: Clone/Open Project
```bash
cd C:\Users\Rites\Documents\Projects\geomute
```

### Step 2: Install Dependencies
```bash
flutter pub get
```

### Step 3: Check Flutter Setup
```bash
flutter doctor
```
Fix any issues shown (accept Android licenses if needed):
```bash
flutter doctor --android-licenses
```

### Step 4: Connect Device or Start Emulator

**Option A: Physical Android Device**
1. Enable Developer Options on your phone:
   - Go to Settings → About Phone
   - Tap "Build Number" 7 times
2. Enable USB Debugging:
   - Settings → Developer Options → USB Debugging
3. Connect phone via USB
4. Verify: `flutter devices`

**Option B: Android Emulator**
1. Open Android Studio
2. Tools → Device Manager
3. Create Virtual Device (Pixel 5, API 30+)
4. Start emulator
5. Verify: `flutter devices`

### Step 5: Run the App

**Debug Mode (for testing):**
```bash
flutter run
```

**Release Mode (optimized):**
```bash
flutter run --release
```

**Build APK:**
```bash
flutter build apk --release
```
APK location: `build\app\outputs\flutter-apk\app-release.apk`

## First Time Setup in App

### 1. Grant Permissions
When app opens, grant these permissions:
- Location (Allow all the time)
- Do Not Disturb access

### 2. Add Your First Zone
1. Tap the "+" button
2. Select location on map (or search)
3. Enter zone name (e.g., "My College")
4. Set radius (100-500m recommended)
5. Choose sound mode (Silent/Vibrate)
6. Tap "Create"

### 3. Test the App
1. Tap "Check Zone" to test detection
2. Tap "Test Mute" to test sound control
3. Walk to your zone to test automatic switching

## Troubleshooting

### Issue: "flutter: command not found"
**Solution:** Add Flutter to PATH and restart terminal

### Issue: "Android licenses not accepted"
**Solution:** Run `flutter doctor --android-licenses` and accept all

### Issue: "No devices found"
**Solution:** 
- Physical device: Enable USB debugging
- Emulator: Start emulator from Android Studio

### Issue: "Gradle build failed"
**Solution:** 
```bash
cd android
gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Issue: "App crashes on launch"
**Solution:** Ensure you have the latest APK from `build\app\outputs\flutter-apk\app-release.apk`

### Issue: "Sound mode not changing"
**Solution:** 
1. Go to phone Settings
2. Search "Do Not Disturb"
3. Grant GeoMute access to DND

### Issue: "Location not detected"
**Solution:**
1. Enable GPS/Location on phone
2. Grant "Allow all the time" location permission
3. Ensure you're outdoors for better GPS signal

## Development Commands

### Run in debug mode with hot reload:
```bash
flutter run
```

### Check for errors:
```bash
flutter analyze
```

### Format code:
```bash
flutter format .
```

### Clean build:
```bash
flutter clean
flutter pub get
```

### View logs:
```bash
flutter logs
```

## Project Structure
```
geomute/
├── lib/
│   ├── main.dart              # App entry point
│   ├── models/
│   │   └── silent_zone.dart   # Zone data model
│   ├── screens/
│   │   ├── home_screen.dart   # Main screen
│   │   ├── map_screen.dart    # Zone selection
│   │   └── about_screen.dart  # About page
│   └── services/
│       ├── location_service.dart  # GPS & geofencing
│       ├── sound_service.dart     # Sound control
│       └── storage_service.dart   # Data storage
├── android/                   # Android native code
├── pubspec.yaml              # Dependencies
└── README.md                 # Project info
```

## System Requirements

### Minimum:
- Windows 10/11, macOS, or Linux
- 8GB RAM
- 10GB free disk space
- Android device (Android 8.0+) or emulator

### Recommended:
- Windows 11 or macOS
- 16GB RAM
- SSD with 20GB free space
- Physical Android device for testing

## Support

For issues:
1. Check `flutter doctor` output
2. Review error messages in terminal
3. Check Android Studio logcat
4. Email: riteshkumar123hi@gmail.com

## Quick Start Summary

```bash
# 1. Navigate to project
cd C:\Users\Rites\Documents\Projects\geomute

# 2. Install dependencies
flutter pub get

# 3. Check setup
flutter doctor

# 4. Run app
flutter run

# 5. Build APK
flutter build apk --release
```

The APK will be at: `build\app\outputs\flutter-apk\app-release.apk`

Install this APK on your Android phone to use the app!
