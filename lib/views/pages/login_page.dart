import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/default_button.dart';
import '../components/text_form_field.dart';
import 'email_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  IconData obsecureIcon = Icons.visibility_off;
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/logo.png',
                  width: 350,
                ),
                const SizedBox(
                  height: 60,
                ),
                myTextFormField(
                  controller: emailController,
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
                  controller: passwordController,
                  isHidden: isHidden,
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
                    color: Colors.grey,
                    onPressed: () {
                      if (isHidden) {
                        obsecureIcon = Icons.visibility;
                      } else {
                        obsecureIcon = Icons.visibility_off;
                      }
                      isHidden = !isHidden;
                      setState(() {});
                    },
                    icon: Icon(obsecureIcon),
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
                    if (formKey.currentState!.validate()) {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('email', emailController.text);
                      if (context.mounted) {
                        emailController.clear();
                        passwordController.clear();
                        Navigator.pushNamed(context, EmailPage.id);
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
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Feature is not available right now'),
                      ),
                    );
                  },
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