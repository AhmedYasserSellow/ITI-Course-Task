import 'package:app/views/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/default_button.dart';
import '../components/text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                defaultButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Sign Up Successful, go to login page')));
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Sign Up failed : weak passwrod')));
                        } else if (e.code == 'email-already-in-use') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Sign Up failed : email already in use')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Sign Up failed ')));
                        }
                      }
                    }
                  },
                  text: 'Sign Up',
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultButton(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, LoginPage.id);
                  },
                  text: 'Already have an account ? Sign In',
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
