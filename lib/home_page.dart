import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoadingFinish = false;
  bool requiredPermission = false;
  Position? currentLocation;

  Future<Position> getLocation() async {
    print("getLocationstart");
    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      return Future.error('Konum izni reddedildi');
    }
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .catchError((e) {
      print('error $e');
    });
  }

  @override
  void initState() {
    super.initState();
    void permissionOK() {
      getLocation().then((pos) {
        isLoadingFinish = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
