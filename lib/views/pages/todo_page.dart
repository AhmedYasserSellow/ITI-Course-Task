import 'package:app/models/todo_model.dart';
import 'package:app/services/todo_service.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});
  static String id = 'TodoPage';
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<TodoModel> todo = [];
  Future getList() async {
    todo = await TODOService().getTODOService();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getList(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Todo List'),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Center(
                    child: Text(
                      todo.length.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
            body: todo.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          iconColor: todo[index].completed!
                              ? const Color.fromRGBO(76, 175, 80, 1)
                              : const Color.fromRGBO(244, 67, 54, 1),
                          textColor: Colors.white,
                          tileColor: const Color(0xff16202a),
                          leading: Icon(
                            todo[index].completed!
                                ? Icons.check_circle_outline
                                : Icons.dangerous_outlined,
                            size: 40,
                          ),
                          title: Text(todo[index].title!),
                          subtitle: Text(todo[index].completed!
                              ? 'Task is Completed'
                              : "Task isn't completed"),
                        );
                      },
                      itemCount: todo.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    ),
                  ),
          );
        });
  }
}
