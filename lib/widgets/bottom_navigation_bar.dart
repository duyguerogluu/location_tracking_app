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
import 'package:location_tracking_app/screens/home_page.dart';
import 'package:location_tracking_app/screens/map_screen.dart';
import 'package:location_tracking_app/screens/marker_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedPage = 0;

  void changePage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  showPage(int selectedPage) {
    if (selectedPage == 0) {
      return const MapScreen();
    } else if (selectedPage == 1) {
      return const HomePage();
    } else if (selectedPage == 2) {
      return const MarkerScreen();
    } else if (selectedPage == 3) {
      return const DirectionScreen();
    } else if (selectedPage == 4) {
      return const DirectionTest();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Bottom Navigation Bar',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
