import 'package:app/views/pages/home_page.dart';
import 'package:app/views/pages/register_page.dart';
import 'package:app/views/pages/todo_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'views/pages/email_page.dart';
import 'views/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF545454),
      )),
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        EmailPage.id: (context) => const EmailPage(),
        TodoPage.id: (context) => const TodoPage(),
        HomePage.id: (context) => const HomePage(),
        RegisterPage.id: (context) => const RegisterPage()
      },
      initialRoute: HomePage.id,
      debugShowCheckedModeBanner: false,
    );
  }
}
