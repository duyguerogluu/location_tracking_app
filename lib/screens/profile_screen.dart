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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Kullanıcı Bilgileri',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/homeOne.jpg'),
                ),
                const SizedBox(height: 16),
                const Text('Ad: duygu'),
                const Text('E-posta: duygu@example.com'),
                const Text('Telefon: +90 123 456 7890'),
                const SizedBox(height: 32),
                const Text(
                  'Ödeme Bilgileri',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text('Kredi Kartı: **** **** **** 1234'),
                const Text('Son Kullanma Tarihi: 12/25'),
                const Text('CVV: ***'),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Ödeme Bilgilerini Güncelle'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
