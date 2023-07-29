import 'package:app/views/pages/todo_page.dart';
import 'package:flutter/material.dart';

import 'views/pages/home.dart';
import 'views/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        HomePage.id: (context) => const HomePage(),
        TodoPage.id: (context) => const TodoPage(),
      },
      initialRoute: TodoPage.id,
      debugShowCheckedModeBanner: false,
    );
  }
}
