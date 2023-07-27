import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
  const NewPage({super.key, required this.email});
  static String id = 'Home';
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'your email is : $email',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
