import 'package:flutter/material.dart';
import 'package:location_tracking_app/models/user.dart';
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
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              return ListView.builder(
                  itemCount: user.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(user.image),
                      title: Text('${user.length} '),
                    );
                  });
            }
          }),
    );
  }
}
