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
import 'package:location_tracking_app/models/user.dart';
import 'package:location_tracking_app/screens/map_screen.dart';
import 'package:location_tracking_app/screens/marker_screen.dart';
import 'package:location_tracking_app/services/user_service.dart';

class FollowedScreen extends StatefulWidget {
  const FollowedScreen({super.key});

  @override
  State<FollowedScreen> createState() => _FollowedScreenState();
}

class _FollowedScreenState extends State<FollowedScreen> {
  final UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Followed List'),
      ),
      body: FutureBuilder<List<User>>(
          future: userService.fetchUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              debugPrint('Error: ${snapshot.error}');
              return Center(
                child: Column(
                  children: [
                    Text('Error: ${snapshot.error}'),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MarkerScreen(users: users)));
                      },
                      child: Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(user.name),
                            subtitle: Text(user.surname),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user.image),
                            ),
                          )),
                    );
                  });
            }
            return const Text('jhkkjlkj');
          }),
    );
  }
}
