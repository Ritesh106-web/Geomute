import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../models/silent_zone.dart';
import '../services/location_service.dart';
import '../services/storage_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final LocationService _locationService = LocationService();
  final StorageService _storageService = StorageService();
  final MapController _mapController = MapController();

  Position? _currentLocation;
  LatLng? _selectedLocation;
  final List<Marker> _markers = [];
  final List<CircleMarker> _circles = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final position = await _locationService.getCurrentLocation();
    if (position != null && mounted) {
      setState(() {
        _currentLocation = position;
        _markers.add(Marker(
          point: LatLng(position.latitude, position.longitude),
          child: const Icon(Icons.my_location, color: Colors.blue, size: 32),
        ));
      });
      _mapController.move(LatLng(position.latitude, position.longitude), 15);
    }
  }

  void _onMapTap(TapPosition tapPosition, LatLng location) {
    setState(() {
      _selectedLocation = location;
      _markers.removeWhere((m) => m.key == const ValueKey('selected'));
      _markers.add(Marker(
        key: const ValueKey('selected'),
        point: location,
        child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
      ));
    });
  }

  Future<void> _addSilentZone() async {
    if (_selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please tap a location on the map')),
      );
      return;
    }

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _ZoneDialog(),
    );

    if (result != null) {
      final zone = SilentZone(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: result['name'],
        latitude: _selectedLocation!.latitude,
        longitude: _selectedLocation!.longitude,
        radius: result['radius'],
        soundMode: result['soundMode'],
      );
      await _storageService.addZone(zone);
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final center = _currentLocation != null
        ? LatLng(_currentLocation!.latitude, _currentLocation!.longitude)
        : const LatLng(12.9716, 77.5946); // Default: Bengaluru

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Silent Zone'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.check), onPressed: _addSilentZone),
        ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: center,
          initialZoom: 15,
          onTap: _onMapTap,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.geomute',
          ),
          CircleLayer(circles: _circles),
          MarkerLayer(markers: _markers),
        ],
      ),
    );
  }
}

class _ZoneDialog extends StatefulWidget {
  @override
  _ZoneDialogState createState() => _ZoneDialogState();
}

class _ZoneDialogState extends State<_ZoneDialog> {
  final _nameController = TextEditingController();
  double _radius = 100;
  String _soundMode = 'silent';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Zone'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Zone Name',
              hintText: 'e.g., College, Office',
            ),
          ),
          const SizedBox(height: 16),
          const Text('Sound Mode:'),
          DropdownButton<String>(
            value: _soundMode,
            isExpanded: true,
            items: const [
              DropdownMenuItem(value: 'silent', child: Text('🔇 Silent')),
              DropdownMenuItem(value: 'vibrate', child: Text('📳 Vibrate')),
              DropdownMenuItem(value: 'normal', child: Text('🔊 Normal')),
            ],
            onChanged: (value) => setState(() => _soundMode = value!),
          ),
          const SizedBox(height: 16),
          Text('Radius: ${_radius.toInt()}m'),
          Slider(
            value: _radius,
            min: 50,
            max: 1000,
            divisions: 19,
            onChanged: (value) => setState(() => _radius = value),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_nameController.text.isNotEmpty) {
              Navigator.pop(context, {
                'name': _nameController.text,
                'radius': _radius,
                'soundMode': _soundMode,
              });
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}
