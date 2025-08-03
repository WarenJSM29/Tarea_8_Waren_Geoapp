// Estudiante: Waren Sanchez || Matricula: 2023-1198

import 'package:flutter/material.dart';
import 'package:geoapp/screens/input_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GeoApp Map",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: const InputScreen(),
    );
  }
}