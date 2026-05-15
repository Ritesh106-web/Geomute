import 'package:flutter/material.dart';

void main() {
  runApp(const SimpleApp());
}

class SimpleApp extends StatelessWidget {
  const SimpleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoMute',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GeoMute'),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Text('App is working!', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
