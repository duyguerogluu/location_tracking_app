/*
 *  This file is part of location_tracking_app.
 *
 *  location_tracking_app is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  location_tracking_app is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *   along with location_tracking_app.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

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

  final Set<Polyline> _polylines = <Polyline>{};

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
        polylines: _polylines,
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getDirection();
  }

  void _getDirection() async {
    final String startPosition =
        "${_startLocation.latitude},${_startLocation.longitude}";
    final String finishPosition =
        "${_finishLocation.latitude},${_finishLocation.longitude}";
    const String destination = "&destination";

    const String mainApi =
        "https://maps.googleapis.com/maps/api/directions/json?origin=";

    const String key = "&key";
    final String apiKey = dotenv.env['apiKey'] ?? "";

    final Uri uri = Uri.parse(
        mainApi + startPosition + destination + finishPosition + key + apiKey);

    var response = await http.get(uri);
  }
}
