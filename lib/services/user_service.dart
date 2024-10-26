import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location_tracking_app/models/user.dart';

class UserService {
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/users'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      debugPrint(response.body);
      return jsonData.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('failed to load users ');
    }
  }
}
