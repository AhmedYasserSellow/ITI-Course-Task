import 'package:app/views/pages/home_page.dart';
import 'package:app/views/pages/todo_page.dart';
import 'package:flutter/material.dart';

import 'views/pages/email_page.dart';
import 'views/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.541),
      )),
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        EmailPage.id: (context) => const EmailPage(),
        TodoPage.id: (context) => const TodoPage(),
        HomePage.id: (context) => const HomePage(),
      },
      initialRoute: HomePage.id,
      debugShowCheckedModeBanner: false,
    );
  }
}
