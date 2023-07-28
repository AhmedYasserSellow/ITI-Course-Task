import 'package:app/components/default_button.dart';
import 'package:app/components/text_form_field.dart';
import 'package:app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static String id = 'LoginPage';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                Image.asset(
                  'assets/logo.png',
                  width: 350,
                ),
                const SizedBox(
                  height: 60,
                ),
                myTextFormField(
                  controller: _controller,
                  validate: (String? value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return "enter a valid e-mail";
                    }
                    return null;
                  },
                  label: 'E-mail',
                  prefix: Icons.email,
                  context: context,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                myTextFormField(
                  validate: (String? value) {
                    if (value!.isEmpty || value.length < 8) {
                      return 'passwword is too short';
                    }
                    return null;
                  },
                  label: 'Password',
                  prefix: Icons.lock,
                  context: context,
                  color: Colors.black,
                  suffix: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Forgot Password ? '),
                    Text(
                      'Tap Me',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultButton(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('email', _controller.text);
                      if (context.mounted) {
                        Navigator.pushNamed(context, HomePage.id);
                      }
                    }
                  },
                  text: 'Login',
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultButton(
                  onTap: () {},
                  text: 'No Account ? Sign Up',
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
