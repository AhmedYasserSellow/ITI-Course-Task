import 'package:app/logic/cubit.dart';
import 'package:app/logic/states.dart';
import 'package:app/views/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/default_button.dart';
import '../components/text_form_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static String id = 'LoginPage';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(builder: (context, state) {
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
                    isHidden: LoginCubit.get(context).isHidden,
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
                        LoginCubit.get(context).changePasswordVisibilty();
                      },
                      icon: Icon(LoginCubit.get(context).obsecureIcon),
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
                        onTap: () {
                          LoginCubit.get(context).forgotPassword(
                              context: context,
                              emailController: emailController);
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
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        LoginCubit.get(context).signIn(
                            context: context,
                            emailController: emailController,
                            passwordController: passwordController);
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
    });
  }
}
