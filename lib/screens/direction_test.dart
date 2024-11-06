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
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionTest extends StatefulWidget {
  const DirectionTest({super.key});

  @override
  State<DirectionTest> createState() => _DirectionTestState();
}

class _DirectionTestState extends State<DirectionTest> {
  late GoogleMapController mapController;
  Set<Polyline> _polylines = {};
  LatLng _startLocation = LatLng(41.40902647035469, 2.2008270607482556);
  LatLng _endLocation = LatLng(41.440519653383596, 2.2451869794393846);

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
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: _startLocation,
        zoom: 14,
      ),
      polylines: _polylines,
    );
  }
}
