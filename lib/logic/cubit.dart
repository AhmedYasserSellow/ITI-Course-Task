import 'package:app/logic/states.dart';
import 'package:app/models/todo_model.dart';
import 'package:app/services/todo_service.dart';
import 'package:app/views/pages/email_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

todoCubit(context) => TodoCubit.get(context);

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(TodoIntialState());

  static TodoCubit get(context) => BlocProvider.of(context);

  List<TodoModel> todo = [];
  Future getList() async {
    try {
      emit(TodoPageIsLoading());
      todo = await TODOService().getTODOService();
      emit(TodoPageIsSuccessful());
    } catch (e) {
      emit(TodoPageError());
    }
  }
}

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginIntialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  bool isHidden = true;

  IconData obsecureIcon = Icons.visibility;
  String? email;
  Future signUp({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Sign Up Successful, go to login page')));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign Up failed : weak passwrod')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Sign Up failed : email already in use')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Sign Up failed ')));
      }
    }
  }

  Future signIn(
      {required BuildContext context,
      required TextEditingController emailController,
      required TextEditingController passwordController}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
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
            const SnackBar(content: Text('No user found for that email')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Wrong password provided for that user')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Login failed')));
      }
    }
  }

  void forgotPassword({
    required BuildContext context,
    required TextEditingController emailController,
  }) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('message sent to your email')));
      }
    } on FirebaseAuthException {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('enter a valid email')));
    }
  }

  void changePasswordVisibilty() {
    if (isHidden) {
      obsecureIcon = Icons.visibility;
    } else {
      obsecureIcon = Icons.visibility_off;
    }
    isHidden = !isHidden;
    emit(LoginPasswordVisibilityState());
  }

  Future getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email')!;
    emit(LoginGetEmilState());
  }
}
