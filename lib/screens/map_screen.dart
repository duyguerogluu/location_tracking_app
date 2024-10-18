import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final LatLng _center = const LatLng(41.406907598969205, 2.173116555622275);

  @override
  Widget build(BuildContext context) {
    Marker firsthome = const Marker(
      markerId: MarkerId('first'),
      position: LatLng(
        41.426208159960815,
        2.188206838022531,
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Google Map")),
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          initialCameraPosition: _camPos(),
          markers: {firsthome},
        ));
  }

  CameraPosition _camPos() {
    return CameraPosition(
      bearing: 00,
      target: _center,
      zoom: 11.0,
      tilt: 60,
    );
  }
}
