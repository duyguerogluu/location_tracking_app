import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoadingFinish = false;
  bool isRequiredPermission = false;
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

  void permissionOK() {
    getLocation().then((pos) {
      isLoadingFinish = true;
      currentLocation = pos;

      if (pos == null) {
        isRequiredPermission = true;
      } else {
        isRequiredPermission = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    permissionOK();
  }

  getLocal() {
    Geolocator.requestPermission().then((request) {
      print("REQUEST : $request");
      if (Platform.isIOS) {
        if (request != LocationPermission.whileInUse) {
          print("NOT LOCATION PERMISSION");
          return;
        } else {
          print("PERMISSION OK");
          permissionOK();
        }
      } else {
        if (request != LocationPermission.always) {
          print("NOT LOCATION PERMISSION");
          return;
        } else {
          print("PERMISSION OK");
          permissionOK();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            getLocal();
          },
          child: const Icon(Icons.map),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            print(
                'x: ${currentLocation?.latitude}   ,      y:${currentLocation?.longitude}');
          },
          child: const Text('Show'),
        ),
      ],
    );
  }
}
