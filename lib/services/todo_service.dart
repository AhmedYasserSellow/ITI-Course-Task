import 'package:app/models/todo_model.dart';
import 'package:dio/dio.dart';

class TODOService {
  String url = 'https://jsonplaceholder.typicode.com/todos';
  Future<List<TodoModel>> getTODOService() async {
    List<TodoModel> todoList = [];
    Response response = await Dio().get(url);
    var data = response.data;
    data.forEach((value) {
      TodoModel todoModel = TodoModel.fromJson(value);
      todoList.add(todoModel);
    });
    return todoList;
  }
}
