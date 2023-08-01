import 'package:app/views/components/details_dialog.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              menuCard(
                color: const Color(0xffb4763c),
                label: 'Login Page',
                image: 'assets/login.png',
                onTap: () {
                  Navigator.pushNamed(context, LoginPage.id);
                },
                detailsButtonOnTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return detailsDialog(
                          context: context,
                          title: 'Login Page',
                          subtitle:
                              '1- Make a login Page with validators\n2-Navigate to another page\n3- Send email used to login to the same page\n4- Add firebase auth to project\n5- Refactor Code using bloc package');
                    },
                  );
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
                  },
                  detailsButtonOnTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return detailsDialog(
                            context: context,
                            title: 'Todo List Page',
                            subtitle:
                                '1- Make todo list model\n2- Make todo list service\n3- Get todo list from api and display it\n4- Make circular progress indicator if todo list is empty\n5- Refactor code using bloc package');
                      },
                    );
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
      ),
    );
  }
}
