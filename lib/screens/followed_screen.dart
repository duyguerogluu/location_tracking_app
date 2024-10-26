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
                    return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(user.name),
                          subtitle: Text(user.surname),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.image),
                          ),
                        ));
                  });
            }
            return const Text('jhkkjlkj');
          }),
    );
  }
}
