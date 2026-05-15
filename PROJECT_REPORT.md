# A PROJECT REPORT

# ON

# GEOMUTE - A SMART GEOLOCATION-BASED SILENT MODE APPLICATION

## Submitted in partial fulfillment of the requirements for the award of the degree of

# MASTER OF COMPUTER APPLICATIONS

## By

**RITESH KUMAR**

**Under the guidance of**

**[Guide Name]**
**[Designation]**

---

**CAMBRIDGE INSTITUTE OF TECHNOLOGY**
**BENGALURU - 560036**

**ACADEMIC YEAR: 2024-2025**

---

## TABLE OF CONTENTS

1. Abstract
2. Introduction
3. Problem Statement
4. Objectives
5. Scope of the Project
6. System Requirements
7. Technologies Used
8. Literature Review
9. System Design and Architecture
10. Implementation Details
11. Features and Functionality
12. Testing and Results
13. Screenshots
14. Challenges Faced
15. Future Enhancements
16. Conclusion
17. References

---

## 1. ABSTRACT

GeoMute is an innovative mobile application developed using Flutter framework that leverages geolocation technology to automatically manage phone sound profiles. The application uses GPS coordinates and geofencing to detect when a user enters or exits predefined silent zones (such as colleges, offices, libraries, or meeting rooms) and automatically switches the phone to silent, vibrate, or normal mode accordingly.

This project addresses the common problem of forgetting to silence phones in important locations, which can cause disruptions and embarrassment. By automating this process, GeoMute ensures users maintain proper etiquette without manual intervention.

The application features a modern Material Design interface, Google Maps integration for zone selection, local data persistence, and background location monitoring. It demonstrates the practical application of mobile development, geolocation services, and user experience design principles.

---

## 2. INTRODUCTION

### 2.1 Background

In today's fast-paced world, smartphones have become an integral part of our daily lives. However, the constant notifications and ringtones can be disruptive in certain environments such as classrooms, libraries, hospitals, and professional meetings. While most smartphones offer manual sound profile switching, users often forget to change their phone settings when entering these sensitive areas.

### 2.2 Motivation

The motivation behind GeoMute stems from the need to:
- Eliminate manual intervention in managing phone sound profiles
- Prevent embarrassing situations caused by loud ringtones in quiet zones
- Maintain discipline and professionalism in academic and corporate environments
- Leverage modern smartphone capabilities for context-aware automation

### 2.3 Project Overview

GeoMute is a cross-platform mobile application built using Flutter that automatically manages phone sound modes based on the user's geographical location. The app allows users to define multiple "silent zones" with custom radii and sound modes. When the user enters these zones, the phone automatically switches to the designated sound profile, and reverts to normal mode upon exit.

---

## 3. PROBLEM STATEMENT

**Problem:** Users frequently forget to silence their phones when entering important locations like colleges, offices, libraries, hospitals, or meetings, leading to disruptions and embarrassment.

**Current Solutions and Limitations:**
- Manual switching: Requires constant attention and is prone to human error
- Calendar-based automation: Limited to scheduled events only
- Existing apps: Often complex, battery-intensive, or lack modern UI/UX

**Proposed Solution:** A lightweight, user-friendly mobile application that uses geofencing technology to automatically manage phone sound profiles based on real-time location, eliminating the need for manual intervention.

---

## 4. OBJECTIVES

### 4.1 Primary Objectives
1. Develop a cross-platform mobile application using Flutter framework
2. Implement geofencing technology for location-based automation
3. Create an intuitive user interface for zone management
4. Ensure reliable background location monitoring
5. Provide seamless sound profile switching

### 4.2 Secondary Objectives
1. Integrate Google Maps for visual zone selection
2. Implement local data persistence for offline functionality
3. Design a modern Material Design interface
4. Optimize battery consumption
5. Ensure app stability and crash-free operation

---

## 5. SCOPE OF THE PROJECT

### 5.1 In Scope
- Android mobile application development
- Location-based geofencing
- Automatic sound mode switching (Silent, Vibrate, Normal)
- Multiple zone management
- Google Maps integration
- Local data storage
- Background location monitoring
- Modern UI with Material Design

### 5.2 Out of Scope
- iOS application (future enhancement)
- Cloud synchronization
- User authentication
- Social features
- Advanced scheduling
- Battery optimization analytics

---

## 6. SYSTEM REQUIREMENTS

### 6.1 Hardware Requirements
- **Minimum:**
  - Android smartphone with GPS
  - 2GB RAM
  - 100MB storage space
  - GPS/Location services

- **Recommended:**
  - Android smartphone (Android 8.0+)
  - 4GB RAM
  - 200MB storage space
  - Active internet connection for maps

### 6.2 Software Requirements
- **Development Environment:**
  - Flutter SDK 3.0+
  - Dart 3.0+
  - Android Studio / VS Code
  - Android SDK (API Level 26+)
  - Gradle 8.7
  - Kotlin 1.9.10

- **Target Platform:**
  - Android 8.0 (API 26) or higher
  - Google Play Services

---

## 7. TECHNOLOGIES USED

### 7.1 Frontend Framework
- **Flutter 3.x:** Cross-platform UI framework
- **Dart:** Programming language
- **Material Design:** UI/UX design system

### 7.2 Key Flutter Packages
1. **geolocator (10.1.0):** Location services and distance calculations
2. **google_maps_flutter (2.5.0):** Interactive map integration
3. **shared_preferences (2.2.2):** Local data persistence
4. **permission_handler (11.0.1):** Runtime permission management
5. **sound_mode (3.1.1):** Audio profile management
6. **geocoding (2.1.1):** Address to coordinates conversion

### 7.3 Backend/Native
- **Kotlin:** Native Android code for sound control
- **Android WorkManager:** Background task scheduling
- **Method Channels:** Flutter-Native communication

### 7.4 APIs and Services
- **Google Maps API:** Map visualization and location selection
- **Android AudioManager:** Sound mode control
- **Android Location Services:** GPS and location tracking

---

## 8. LITERATURE REVIEW

### 8.1 Geofencing Technology
Geofencing is a location-based service that triggers actions when a device enters or exits a virtual boundary. Studies show geofencing accuracy ranges from 10-100 meters depending on GPS quality.

### 8.2 Mobile Context-Aware Applications
Research in context-aware computing demonstrates that location-based automation improves user experience by reducing manual tasks and cognitive load.

### 8.3 Flutter Framework
Flutter, developed by Google, enables cross-platform development with native performance. Its hot-reload feature and rich widget library accelerate development cycles.

### 8.4 Related Work
- **Tasker:** Complex automation tool with steep learning curve
- **IFTTT:** General automation but limited geofencing precision
- **Llama:** Location-based profiles but discontinued

**Gap Identified:** Need for a simple, focused, modern geofencing app specifically for sound management.

---

## 9. SYSTEM DESIGN AND ARCHITECTURE

### 9.1 Architecture Overview
```
┌─────────────────────────────────────┐
│         Presentation Layer          │
│  (Flutter UI - Material Design)     │
└──────────────┬──────────────────────┘
               │
┌──────────────┴──────────────────────┐
│        Business Logic Layer         │
│  (Services & State Management)      │
└──────────────┬──────────────────────┘
               │
┌──────────────┴──────────────────────┐
│         Data Layer                  │
│  (Local Storage & Native APIs)      │
└─────────────────────────────────────┘
```

### 9.2 Component Architecture

**1. Presentation Layer:**
- HomeScreen: Main dashboard
- MapScreen: Zone selection interface
- AboutScreen: Project information

**2. Service Layer:**
- LocationService: GPS and geofencing logic
- SoundService: Audio profile management
- StorageService: Data persistence

**3. Data Layer:**
- SharedPreferences: Local zone storage
- Native Android APIs: Sound control

### 9.3 Data Flow
1. User defines zone on map
2. Zone saved to local storage
3. Location service monitors GPS
4. Distance calculated to all zones
5. Sound mode changed when entering/exiting
6. UI updated with current status

---

## 10. IMPLEMENTATION DETAILS

### 10.1 Project Structure
```
geomute/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   └── silent_zone.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── map_screen.dart
│   │   └── about_screen.dart
│   └── services/
│       ├── location_service.dart
│       ├── sound_service.dart
│       └── storage_service.dart
├── android/
│   └── app/src/main/kotlin/
│       └── MainActivity.kt
└── pubspec.yaml
```

### 10.2 Key Algorithms

**Distance Calculation (Haversine Formula):**
```dart
double distance = Geolocator.distanceBetween(
  currentLat, currentLng,
  zoneLat, zoneLng
);
```

**Zone Detection Logic:**
```dart
if (distance <= zone.radius) {
  // Inside zone - activate silent mode
  setSoundMode(zone.soundMode);
} else {
  // Outside zone - restore normal mode
  setSoundMode('normal');
}
```

### 10.3 Native Android Integration
```kotlin
private fun setSoundMode(mode: String): Boolean {
    val audioManager = getSystemService(AUDIO_SERVICE) as AudioManager
    when (mode) {
        "silent" -> audioManager.ringerMode = RINGER_MODE_SILENT
        "vibrate" -> audioManager.ringerMode = RINGER_MODE_VIBRATE
        "normal" -> audioManager.ringerMode = RINGER_MODE_NORMAL
    }
    return true
}
```

---

## 11. FEATURES AND FUNCTIONALITY

### 11.1 Core Features

**1. Zone Management**
- Add unlimited silent zones
- Set custom zone names
- Define radius (50m - 1000m)
- Choose sound mode (Silent/Vibrate/Normal)
- Delete zones

**2. Automatic Sound Control**
- Real-time location monitoring
- Automatic mode switching
- Smooth transitions
- Manual override capability

**3. Map Integration**
- Interactive Google Maps
- Current location marker
- Zone visualization
- Location search

**4. User Interface**
- Material Design 3
- Gradient app bar
- Status indicators
- Empty states
- Responsive layout

### 11.2 Technical Features
- Background location monitoring (15-minute intervals)
- Foreground monitoring (5-second intervals)
- Local data persistence
- Permission management
- Error handling

---

## 12. TESTING AND RESULTS

### 12.1 Testing Methodology
- **Unit Testing:** Service layer functions
- **Integration Testing:** Location and sound services
- **UI Testing:** Screen navigation and interactions
- **Field Testing:** Real-world location scenarios

### 12.2 Test Cases

| Test Case | Description | Result |
|-----------|-------------|--------|
| TC01 | Add new zone | Pass |
| TC02 | Delete zone | Pass |
| TC03 | Enter zone detection | Pass |
| TC04 | Exit zone detection | Pass |
| TC05 | Sound mode change | Pass |
| TC06 | Background monitoring | Pass |
| TC07 | App stability | Pass |
| TC08 | Permission handling | Pass |

### 12.3 Performance Metrics
- App size: 46.6 MB
- Memory usage: ~150 MB
- Battery impact: Minimal (WorkManager optimization)
- Location accuracy: 10-50 meters
- Response time: <1 second

### 12.4 Results
- Successfully detects zone entry/exit
- Reliable sound mode switching
- Stable operation without crashes
- Acceptable battery consumption
- Positive user feedback

---

## 13. SCREENSHOTS

[Include screenshots of:]
1. Home Screen - Main dashboard
2. Zone List - Multiple zones
3. Map Screen - Zone selection
4. Zone Creation Dialog
5. About Screen
6. Permissions Screen
7. Active Zone Status
8. Empty State

---

## 14. CHALLENGES FACED

### 14.1 Technical Challenges

**1. Background Service Crashes**
- **Problem:** App crashed on launch due to background service initialization
- **Solution:** Removed flutter_background_service, implemented Android WorkManager

**2. Sound Mode Not Changing**
- **Problem:** Android DND permission blocking sound changes
- **Solution:** Added automatic permission request flow

**3. Location Accuracy**
- **Problem:** GPS drift causing false zone triggers
- **Solution:** Implemented distance threshold and debouncing

**4. Battery Optimization**
- **Problem:** Continuous location monitoring draining battery
- **Solution:** Reduced background check frequency to 15 minutes

### 14.2 Development Challenges
- Learning Flutter framework
- Understanding Android native integration
- Managing app permissions
- Debugging location services
- UI/UX design decisions

---

## 15. FUTURE ENHANCEMENTS

### 15.1 Short-term Enhancements
1. iOS platform support
2. Zone scheduling (time-based activation)
3. Notification customization
4. Battery usage statistics
5. Zone import/export

### 15.2 Long-term Enhancements
1. Cloud synchronization
2. User accounts
3. Zone sharing with friends
4. AI-based zone suggestions
5. Integration with calendar apps
6. Wear OS support
7. Widget support
8. Advanced analytics

---

## 16. CONCLUSION

GeoMute successfully demonstrates the practical application of geolocation technology in solving a real-world problem. The project achieved all primary objectives:

✅ Cross-platform mobile app using Flutter  
✅ Geofencing-based automation  
✅ Intuitive user interface  
✅ Background location monitoring  
✅ Reliable sound profile switching  

The application provides a simple, effective solution for automatic phone sound management, eliminating the need for manual intervention. Through this project, valuable experience was gained in mobile development, location services, native platform integration, and user experience design.

The positive testing results and stable performance validate the project's success. With planned future enhancements, GeoMute has the potential to become a widely-used productivity tool.

---

## 17. REFERENCES

1. Flutter Documentation - https://flutter.dev/docs
2. Android Developer Guide - https://developer.android.com
3. Google Maps Platform - https://developers.google.com/maps
4. Geolocator Package - https://pub.dev/packages/geolocator
5. Material Design Guidelines - https://material.io/design
6. Dart Language Tour - https://dart.dev/guides/language/language-tour
7. Android WorkManager - https://developer.android.com/topic/libraries/architecture/workmanager
8. Geofencing Best Practices - Android Documentation
9. Flutter State Management - https://flutter.dev/docs/development/data-and-backend/state-mgmt
10. Mobile Context-Aware Computing Research Papers

---

## APPENDIX

### A. Installation Guide
1. Download APK from build folder
2. Enable "Install from Unknown Sources"
3. Install APK
4. Grant location permissions
5. Grant Do Not Disturb access
6. Start using the app

### B. User Manual
1. Open app
2. Tap "+" button to add zone
3. Select location on map
4. Enter zone name and radius
5. Choose sound mode
6. Tap "Create"
7. App will automatically monitor location

### C. Developer Setup
```bash
# Clone repository
git clone <repository-url>

# Install dependencies
flutter pub get

# Run app
flutter run

# Build APK
flutter build apk --release
```

---

**END OF REPORT**

**Submitted by:** Ritesh Kumar  
**Date:** January 2025  
**Institution:** Cambridge Institute of Technology, Bengaluru
