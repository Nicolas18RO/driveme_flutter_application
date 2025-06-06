import 'package:drive_me_application_v02/Componets/MyText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1Ijoibmljb2xhczExOHJvIiwiYSI6ImNtYmtjN2xwZzA3Z3Yya3B4cmpldXZsNWsifQ.5O7yMEJ2kWanOhBfugmNvw';

const myPosition = LatLng(5.3093300, -73.8157500);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: const MapOptions(
            initialCenter: myPosition,
            minZoom: 5,
            maxZoom: 25,
            initialZoom: 18),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
            additionalOptions: const {
              'accessToken': MAPBOX_ACCESS_TOKEN,
              'id': 'mapbox/streets-v12'
            },
          ),
          MarkerLayer(markers: [
            Marker(
                point: myPosition,
                child: Container(
                  child: const Icon(
                    Icons.person_pin,
                    color: Colors.blueAccent,
                    size: 40,
                  ),
                ))
          ])
        ],
      ),
    );
  }
}
