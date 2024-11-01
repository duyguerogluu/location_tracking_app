import 'package:flutter/material.dart';

class TesttScreen extends StatefulWidget {
  const TesttScreen({super.key});

  @override
  State<TesttScreen> createState() => _TesttScreenState();
}

class _TesttScreenState extends State<TesttScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:Text('hello'),
    );
  }
}