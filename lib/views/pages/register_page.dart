import 'package:app/views/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit.dart';
import '../../logic/states.dart';
import '../components/default_button.dart';
import '../components/text_form_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  static String id = 'RegisterPage';

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
                  defaultButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        LoginCubit.get(context).signUp(
                          context: context,
                          emailController: emailController,
                          passwordController: passwordController,
                        );
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
    });
  }
}
