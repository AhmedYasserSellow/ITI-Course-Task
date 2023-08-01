import 'package:app/logic/cubit.dart';
import 'package:app/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailPage extends StatelessWidget {
  const EmailPage({
    super.key,
  });
  static String id = 'EmailPage';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Email Page'),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'your email is : ${LoginCubit.get(context).email}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      );
    });
  }
}
