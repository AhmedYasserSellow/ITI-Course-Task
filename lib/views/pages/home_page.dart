import 'package:app/views/components/menu_card.dart';
import 'package:app/views/pages/login_page.dart';
import 'package:app/views/pages/todo_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ITI Course Application'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            menuCard(
              color: const Color(0xffb4763c),
              label: 'Login Page',
              image: 'assets/login.png',
              onTap: () {
                Navigator.pushNamed(context, LoginPage.id);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 10,
              thickness: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            menuCard(
                color: const Color(0xff16202a),
                label: 'Todo Api Page',
                image: 'assets/api.png',
                onTap: () {
                  Navigator.pushNamed(context, TodoPage.id);
                }),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 10,
              thickness: 2,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
