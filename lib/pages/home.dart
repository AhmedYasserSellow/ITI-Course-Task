import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPage extends StatefulWidget {
  const NewPage({
    super.key,
  });
  static String id = 'Home';

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  Future getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
  }

  String? email;
  @override
  void initState() {
    super.initState();
    getEmail();
  }

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
