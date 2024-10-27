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

import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracking_app/models/user.dart';

class MarkerScreen extends StatefulWidget {
  final List<User> users;
  const MarkerScreen({super.key, required this.users});

  @override
  State<MarkerScreen> createState() => _MarkerScreenState();
}

class _MarkerScreenState extends State<MarkerScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final LatLng _center = const LatLng(41.406907598969205, 2.173116555622275);
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    icons();
  }

  // static const CameraPosition _kCasaBatllo = CameraPosition(
  //     target: LatLng(41.406907598969205, 2.173116555622275), zoom: 14);

  static const _homeOne = LatLng(41.397241241482114, 2.175503895690009);
  static const _homeTwo = LatLng(41.39801386026448, 2.1585094187856884);
  static const _homeThree = LatLng(41.426208159960815, 2.188206838022531);

  BitmapDescriptor homeOneIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor homeTwoIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor homeThreeIcon = BitmapDescriptor.defaultMarker;

  @override
  Widget build(BuildContext context) {
    Marker homeOne = addMarker('homeOne', _homeOne, homeOneIcon, 'Birinci Ev');
    Marker homeTwo = addMarker('homeTwo', _homeTwo, homeTwoIcon, 'İkinci Ev');
    Marker homeThree =
        addMarker('homeThree', _homeThree, homeThreeIcon, 'Üçüncü Ev');

    return GoogleMap(
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      initialCameraPosition: _camPos(),
      markers: _createMarkers(),
    );
  }

  Set<Marker> _createMarkers() {
    Set<Marker> markers = {};
    for (int i = 0; i < widget.users.length; i++) {
      final user = widget.users[i];
      LatLng userLocation =
          LatLng(user.location.latitude, user.location.longitude);
      markers.add(
        addMarker('user${i + 1}', userLocation, BitmapDescriptor.defaultMarker,
            '${user.name} ${user.surname}'),
      );
    }
    return markers;
  }

  CameraPosition _camPos() {
    return CameraPosition(
      bearing: 0,
      target: _center,
      zoom: 11.0,
      tilt: 60,
    );
  }

  Marker addMarker(
      String id, LatLng position, BitmapDescriptor icon, String title) {
    return Marker(
      markerId: MarkerId(id),
      position: position,
      icon: icon,
      infoWindow: InfoWindow(
        title: title,
      ),
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void icons() async {
    final Uint8List homeOneMarkerIcon =
        await getBytesFromAsset('assets/homeOne.jpg', 44);
    homeOneIcon = BitmapDescriptor.bytes(homeOneMarkerIcon);

    final Uint8List homeTwoMarkerIcon =
        await getBytesFromAsset('assets/homeTwo.jpg', 44);
    homeTwoIcon = BitmapDescriptor.bytes(homeTwoMarkerIcon);

    final Uint8List homeThreeMarkerIcon =
        await getBytesFromAsset('assets/homeThree.jpeg', 44);
    homeThreeIcon = BitmapDescriptor.bytes(homeThreeMarkerIcon);

    setState(() {});
  }
}
