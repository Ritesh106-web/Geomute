import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/silent_zone.dart';
import '../services/location_service.dart';
import '../services/sound_service.dart';
import '../services/storage_service.dart';
import 'map_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocationService _locationService = LocationService();
  final SoundService _soundService = SoundService();
  final StorageService _storageService = StorageService();

  List<SilentZone> _zones = [];
  Position? _currentLocation;
  String _currentSoundMode = 'normal';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
    _startLocationMonitoring();
  }

  void _startLocationMonitoring() {
    try {
      Timer.periodic(const Duration(seconds: 5), (timer) {
        if (mounted) {
          _checkCurrentZone();
        }
      });
    } catch (e) {
      print('Location monitoring error: $e');
    }
  }

  Future<void> _checkCurrentZone() async {
    try {
      await _updateLocation();
      if (_currentLocation != null) {
        await _locationService.checkZones();
        await Future.delayed(const Duration(milliseconds: 500));
        final newSoundMode = await _soundService.getCurrentSoundMode();
        if (newSoundMode != _currentSoundMode && mounted) {
          setState(() {
            _currentSoundMode = newSoundMode;
          });
        }
      }
    } catch (e) {
      print('Check zone error: $e');
    }
  }

  Future<void> _initializeApp() async {
    try {
      await _requestPermissions();
      await _loadZones();
      await _updateLocation();
      await _updateSoundMode();
      _locationService.updateSilentZones(_zones);
    } catch (e) {
      print('Init error: $e');
    }
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }


  Future<void> _requestPermissions() async {
    await _locationService.requestPermissions();
  }

  Future<void> _loadZones() async {
    try {
      _zones = await _storageService.loadZones();
    } catch (e) {
      print('Load zones error: $e');
      _zones = [];
    }
  }

  Future<void> _updateLocation() async {
    try {
      _currentLocation = await _locationService.getCurrentLocation();
    } catch (e) {
      print('Update location error: $e');
    }
  }

  Future<void> _updateSoundMode() async {
    try {
      _currentSoundMode = await _soundService.getCurrentSoundMode();
    } catch (e) {
      print('Update sound mode error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[700]!, Colors.blue[500]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('GeoMute', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Location-Based Sound Control', style: TextStyle(fontSize: 12)),
          ],
        ),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutScreen()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusCard(),
            const SizedBox(height: 20),
            _buildLocationCard(),
            const SizedBox(height: 20),
            _buildZonesSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MapScreen()),
        ).then((_) => _refreshData()),
        icon: const Icon(Icons.add_location_alt),
        label: const Text('Add Zone'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildStatusCard() {
    final isInZone = _locationService.isInSilentZone;
    final modeColor = _currentSoundMode == 'silent' 
        ? Colors.red 
        : _currentSoundMode == 'vibrate' 
        ? Colors.orange 
        : Colors.green;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.volume_up, color: Colors.blue[700]),
                    const SizedBox(width: 8),
                    const Text('Current Mode', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: modeColor[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _currentSoundMode.toUpperCase(),
                    style: TextStyle(
                      color: modeColor[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.blue[700]),
                    const SizedBox(width: 8),
                    const Text('Zone Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  ],
                ),
                Text(
                  isInZone ? 'Inside Zone' : 'Outside Zone',
                  style: TextStyle(
                    color: isInZone ? Colors.orange[700] : Colors.grey[600],
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _checkCurrentZone,
                    icon: const Icon(Icons.my_location, size: 18),
                    label: const Text('Check Zone'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _testSoundControl,
                    icon: const Icon(Icons.volume_off, size: 18),
                    label: const Text('Test Mute'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.gps_fixed, color: Colors.blue[600], size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current Location', 
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700])),
                  const SizedBox(height: 4),
                  if (_currentLocation != null) ...[
                    Text(
                      '${_currentLocation!.latitude.toStringAsFixed(6)}, ${_currentLocation!.longitude.toStringAsFixed(6)}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ] else
                    Text('Location unavailable', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildZonesSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Silent Zones (${_zones.length})', 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800])
            ),
          ),
          Expanded(
            child: _zones.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_off, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'No silent zones configured',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap + to add your first zone',
                          style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _zones.length,
                    itemBuilder: (context, index) => _buildZoneCard(_zones[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildZoneCard(SilentZone zone) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: zone.isActive ? Colors.blue[100] : Colors.grey[200],
          child: Icon(
            Icons.location_on, 
            color: zone.isActive ? Colors.blue[700] : Colors.grey[600],
          ),
        ),
        title: Text(
          zone.name,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Text(
          '${zone.radius.toInt()}m radius • ${zone.soundMode}',
          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.red[400]),
          onPressed: () => _deleteZone(zone.id),
        ),
      ),
    );
  }

  Future<void> _deleteZone(String zoneId) async {
    await _storageService.removeZone(zoneId);
    await _refreshData();
  }

  Future<void> _refreshData() async {
    await _loadZones();
    await _updateLocation();
    await _updateSoundMode();
    _locationService.updateSilentZones(_zones);
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _testSoundControl() async {
    try {
      final currentMode = await _soundService.getCurrentSoundMode();
      if (currentMode == 'silent') {
        await _soundService.setSoundMode('normal');
      } else {
        await _soundService.setSoundMode('silent');
      }
      await Future.delayed(const Duration(milliseconds: 500));
      await _updateSoundMode();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Test sound error: $e');
    }
  }
}