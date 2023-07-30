import 'package:app/logic/cubit.dart';
import 'package:app/logic/states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});
  static String id = 'TodoPage';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return TodoCubit()..getList();
        },
        child: BlocConsumer<TodoCubit, TodoStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Todo List'),
                    centerTitle: true,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Center(
                          child: Text(
                            todoCubit(context).todo.length.toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                  body: state is TodoPageIsLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : state is TodoPageIsSuccessful
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10),
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    iconColor: todoCubit(context)
                                            .todo[index]
                                            .completed!
                                        ? const Color.fromRGBO(76, 175, 80, 1)
                                        : const Color.fromRGBO(244, 67, 54, 1),
                                    textColor: Colors.white,
                                    tileColor: const Color(0xff16202a),
                                    leading: Icon(
                                      todoCubit(context).todo[index].completed!
                                          ? Icons.check_circle_outline
                                          : Icons.dangerous_outlined,
                                      size: 40,
                                    ),
                                    title: Text(
                                        todoCubit(context).todo[index].title!),
                                    subtitle: Text(
                                        '\nTask ID : ${todoCubit(context).todo[index].id}\nUser ID : ${todoCubit(context).todo[index].userId}'),
                                  );
                                },
                                itemCount: todoCubit(context).todo.length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                              ),
                            )
                          : const Center(
                              child: Text(
                                'Error',
                                style: TextStyle(fontSize: 30),
                              ),
                            ));
            }));
  }
}
