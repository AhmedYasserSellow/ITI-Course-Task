import 'package:app/views/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Forgot Password ? '),
                    InkWell(
                      onTap: () async {
                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: emailController.text);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('message sent to your email')));
                          }
                        } on FirebaseAuthException {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('enter a valid email')));
                        }
                      },
                      child: const Text(
                        'Tap Me',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
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
                      try {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('email', emailController.text);
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        if (context.mounted) {
                          emailController.clear();
                          passwordController.clear();
                          Navigator.pushNamed(context, EmailPage.id);
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('No user found for that email')));
                        } else if (e.code == 'wrong-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Wrong password provided for that user')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login failed')));
                        }
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
                    Navigator.pushReplacementNamed(context, RegisterPage.id);
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
