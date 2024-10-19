import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionScreen extends StatefulWidget {
  const DirectionScreen({super.key});

  @override
  State<DirectionScreen> createState() => _DirectionScreenState();
}

class _DirectionScreenState extends State<DirectionScreen> {
  GoogleMapController? mapController;

  final LatLng _center = const LatLng(41.406907598969205, 2.173116555622275);
  final LatLng _startLocation =
      const LatLng(41.40902647035469, 2.2008270607482556);
  final LatLng _finishLocation =
      const LatLng(41.440519653383596, 2.2451869794393846);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Direction Screen'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 7.0,
        ),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getDirection();
  }

  void _getDirection() {
    final String startPosition =
        "${_startLocation.latitude},${_startLocation.longitude}";
    final String finishPosition =
        "${_finishLocation.latitude},${_finishLocation.longitude}";
    const String destination = "&destination";
  }
}
