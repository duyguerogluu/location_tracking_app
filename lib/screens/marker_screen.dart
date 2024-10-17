import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerScreen extends StatefulWidget {
  const MarkerScreen({super.key});

  @override
  State<MarkerScreen> createState() => _MarkerScreenState();
}

class _MarkerScreenState extends State<MarkerScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final LatLng _center = const LatLng(36.8121, 34.6415);
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Google Map")),
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            _addMarker(const LatLng(36.8121, 34.6415));
          },
          initialCameraPosition: _camPos(),
        ));
  }

  CameraPosition _camPos() {
    return CameraPosition(
      bearing: 0,
      target: _center,
      zoom: 11.0,
      tilt: 60,
    );
  }

  void _addMarker(LatLng position) {
    final String markerId = position.toString();
    _markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: position,
        infoWindow: const InfoWindow(
          title: 'Marker',
          snippet: 'Snippet',
        ),
      ),
    );
    setState(() {});
  }
}
