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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location_tracking_app/api.dart';

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
        title: const Center(
          child: Text(
            'Direction Screen',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _startLocation,
          zoom: 10.0,
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
    const String destination = "&destination=";

    const String mainApi =
        "https://maps.googleapis.com/maps/api/directions/json?origin=";

    const String key = "&key";
    // final String apiKey = dotenv.env['apiKey'] ?? "";

    final Uri uri = Uri.parse(
        mainApi + startPosition + destination + finishPosition + key + apiKey);

    var response = await http.get(uri);
    debugPrint(response.body);

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);

      if (data['routes'].isNotEmpty) {
        String encodedString = data['routes'][0]['overview_polyline']['points'];
        List<LatLng> points = _decodePoly(encodedString);

        setState(() {
          _polylines.add(
            Polyline(
              polylineId: const PolylineId('first'),
              points: points,
              visible: true,
              width: 3,
              color: Colors.green,
            ),
          );
        });
      } else {
        debugPrint('No routes found');
        _showErrorDialog('No routes found');
      }
    } else {
      debugPrint('Error: ${response.statusCode}');
    }
  }

  _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  List<LatLng> _decodePoly(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int b;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      LatLng point = LatLng(lat / 1E5, lng / 1E5);
      points.add(point);
    }

    return points;
  }
}
