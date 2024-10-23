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
    debugPrint("getLocationstart");
    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      return Future.error('Konum izni reddedildi');
    }
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .catchError((e) {
      debugPrint('error $e');
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
      debugPrint("REQUEST : $request");
      if (Platform.isIOS) {
        if (request != LocationPermission.whileInUse) {
          debugPrint("NOT LOCATION PERMISSION");
          return;
        } else {
          debugPrint("PERMISSION OK");
          permissionOK();
        }
      } else {
        if (request != LocationPermission.always) {
          debugPrint("NOT LOCATION PERMISSION");
          return;
        } else {
          debugPrint("PERMISSION OK");
          permissionOK();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
              final snackBar = SnackBar(
                content: Center(
                  child: Text(
                      'x: ${currentLocation?.latitude}   ,      y:${currentLocation?.longitude}'),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              debugPrint(
                  'x: ${currentLocation?.latitude}   ,      y:${currentLocation?.longitude}');
            },
            child: const Text('Show'),
          ),
        ],
      ),
    );
  }
}
