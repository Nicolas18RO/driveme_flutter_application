import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MapboxMap? mapboxMapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: MapWidget(
          onMapCreated: (controller) {
            setState(() {
              mapboxMapController = controller;
            });
          },
        ),
      ),
    );
  }
}
