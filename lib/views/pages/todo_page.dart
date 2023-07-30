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
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(todo[index].title!),
                      );
                    },
                    itemCount: todo.length,
                  ),
          );
        });
  }
}
