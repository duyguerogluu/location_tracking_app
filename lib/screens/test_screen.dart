import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracking_app/models/user.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kVerona = CameraPosition(
      target: LatLng(45.43737577404498, 10.997691100672826), zoom: 14.4746);

  static const _julietHome = LatLng(45.44266391721894, 10.99873082349294);
  static const _romeoHome = LatLng(45.444300459532826, 10.999193135733986);
  static const _veronaArena = LatLng(45.43964270398411, 10.994390997076065);
  static const _verona = LatLng(45.43824320692251, 10.991844909323326);

  final Marker veronaMarker = const Marker(
      markerId: MarkerId('verona'),
      position: _verona,
      infoWindow: InfoWindow(title: 'Verona'));

  BitmapDescriptor romeoIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor julietIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor arenaIcon = BitmapDescriptor.defaultMarker;
  @override
  void initState() {
    super.initState();
    _getCustomMarker();
  }

  void _getCustomMarker() async {
    final Uint8List romeoMarkerIcon =
        await getBytesFromAsset('assets/homeOne.jpg', 44);
    romeoIcon = BitmapDescriptor.bytes(romeoMarkerIcon);

    final Uint8List julietMarkerIcon =
        await getBytesFromAsset('assets/homeTwo.jpg', 44);
    julietIcon = BitmapDescriptor.bytes(julietMarkerIcon);

    final Uint8List arenaMarkerIcon =
        await getBytesFromAsset('assets/homeThree.jpeg', 44);
    arenaIcon = BitmapDescriptor.bytes(arenaMarkerIcon);

    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    final Marker romeoMarker =
        createMarker('romeo', _romeoHome, romeoIcon, 'Casa di Romeo');
    final Marker julietMarker =
        createMarker('juliet', _julietHome, julietIcon, 'Casa di Giulietta');
    final Marker arenaMarker =
        createMarker('arena', _veronaArena, arenaIcon, 'Arena di Verona');

    return Scaffold(
      appBar: AppBar(title: const Text("Marker Sample")),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kVerona,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {romeoMarker, julietMarker, arenaMarker, veronaMarker},
      ),
    );
  }

  Marker createMarker(
      String id, LatLng position, BitmapDescriptor icon, String title) {
    return Marker(
      markerId: MarkerId(id),
      position: position,
      icon: icon,
      infoWindow: InfoWindow(title: title),
    );
  }
}
