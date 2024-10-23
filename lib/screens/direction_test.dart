import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionTest extends StatefulWidget {
  const DirectionTest({super.key});

  @override
  State<DirectionTest> createState() => _DirectionTestState();
}

class _DirectionTestState extends State<DirectionTest> {
  final Set<Polyline> _polylines = <Polyline>{};

  @override
  void initState() {
    super.initState();
    _addPolylines();
  }

  _addPolylines() {
    _polylines.add(
      const Polyline(
        polylineId: PolylineId("first"),
        points: [
          LatLng(41.40902647035469, 2.2008270607482556),
          LatLng(41.440519653383596, 2.2451869794393846),
        ],
        color: Colors.deepPurple,
        width: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      polylines: _polylines,
      initialCameraPosition: const CameraPosition(
        target: LatLng(41.406907598969205, 2.173116555622275),
        zoom: 12,
      ),
    );
  }
}
