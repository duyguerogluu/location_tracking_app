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
import 'package:location_tracking_app/screens/direction_screen.dart';
import 'package:location_tracking_app/screens/direction_test.dart';
import 'package:location_tracking_app/screens/direction_testone.dart';
import 'package:location_tracking_app/screens/followed_screen.dart';
import 'package:location_tracking_app/screens/map_screen.dart';
import 'package:location_tracking_app/screens/profile_screen.dart';
import 'package:location_tracking_app/screens/test_screen.dart';
import 'package:location_tracking_app/widgets/bottom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TestOne(),
    );
  }
}
