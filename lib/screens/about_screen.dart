import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About GeoMute'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'About GeoMute',
              'GeoMute is a smart geolocation-based mobile application developed using Flutter. '
              'The app automatically switches your phone to silent mode when you enter specific locations '
              '(like your college or office) and restores it to normal mode when you leave. '
              'It\'s designed to minimize distractions and maintain discipline in silent zones such as '
              'classrooms, libraries, or meetings — without requiring manual effort.',
            ),
            const SizedBox(height: 20),
            _buildProjectInfo(),
            const SizedBox(height: 20),
            _buildSection(
              'Purpose',
              'The goal of this project is to develop a smart and context-aware mobile application that uses '
              'geofencing technology to automate sound profiles, helping users stay focused and professional '
              'in designated zones.',
            ),
            const SizedBox(height: 20),
            _buildFeatures(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Project Title', 'GeoMute – A Smart Geolocation-Based Silent Mode Application'),
            _buildInfoRow('Developed By', 'Ritesh Kumar'),
            _buildInfoRow('Email', 'riteshkumar123hi@gmail.com'),
           
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatures() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Key Features',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            const SizedBox(height: 12),
            _buildFeatureItem('🔇', 'Automatic Sound Control'),
            _buildFeatureItem('📍', 'Multiple Silent Zones'),
            _buildFeatureItem('🔄', 'Background Location Tracking'),
            _buildFeatureItem('🗺️', 'Google Maps Integration'),
            _buildFeatureItem('💾', 'Local Data Storage'),
            _buildFeatureItem('⚡', 'Smart Geofencing Technology'),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String icon, String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 12),
          Text(feature, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}