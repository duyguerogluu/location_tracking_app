import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
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
  void initState() {
    super.initState();
    icons();
  }

  static const CameraPosition _kCasaBatllo = CameraPosition(
      target: LatLng(41.406907598969205, 2.173116555622275), zoom: 14);

  static const _homeOne = LatLng(41.397241241482114, 2.175503895690009);
  static const _homeTwo = LatLng(41.39801386026448, 2.1585094187856884);
  static const _homeThree = LatLng(41.426208159960815, 2.188206838022531);
  static const _homefour = LatLng(41.42878237257088, 2.209836171110227);

  BitmapDescriptor homeOneIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor homeTwoIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor homeThreeIcon = BitmapDescriptor.defaultMarker;

  @override
  Widget build(BuildContext context) {
    Marker homeOne = addMarker('first', _homeOne, homeTwoIcon, 'Birinci Ev');
    Marker homeTwo = addMarker('first', _homeTwo, homeTwoIcon, 'İkinci Ev');
    Marker homeThree = addMarker('first', _homeThree, homeTwoIcon, 'Üçüncü Ev');

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
        markers: {homeOne, homeTwo, homeThree},
      ),
    );
  }

  CameraPosition _camPos() {
    return CameraPosition(
      bearing: 0,
      target: _center,
      zoom: 11.0,
      tilt: 60,
    );
  }

  addMarker(String id, LatLng position, BitmapDescriptor icon, String title) {
    Marker(
      markerId: MarkerId(id),
      position: position,
      infoWindow: InfoWindow(
        title: title,
      ),
    );
    setState(() {});
  }

//imagelerin bytelerını maps e uygun hale getirmek için byte düzenlmesini yapmam lazım
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
        await getBytesFromAsset('assets/homeThree.jpeg', 100);
    homeOneIcon = BitmapDescriptor.bytes(homeOneMarkerIcon);
    final Uint8List homeTwoMarkerIcon =
        await getBytesFromAsset('assets/homeThree.jpeg', 100);
    homeTwoIcon = BitmapDescriptor.bytes(homeTwoMarkerIcon);
    final Uint8List homeThreeMarkerIcon =
        await getBytesFromAsset('assets/homeThree.jpeg', 100);
    homeThreeIcon = BitmapDescriptor.bytes(homeThreeMarkerIcon);

    setState(() {});
  }
}
