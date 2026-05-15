class SilentZone {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final double radius;
  final bool isActive;
  final String soundMode;

  SilentZone({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.radius,
    this.isActive = true,
    this.soundMode = 'silent',
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'latitude': latitude,
    'longitude': longitude,
    'radius': radius,
    'isActive': isActive,
    'soundMode': soundMode,
  };

  factory SilentZone.fromJson(Map<String, dynamic> json) => SilentZone(
    id: json['id'],
    name: json['name'],
    latitude: json['latitude'],
    longitude: json['longitude'],
    radius: json['radius'],
    isActive: json['isActive'] ?? true,
    soundMode: json['soundMode'] ?? 'silent',
  );
}