import 'package:app/logic/states.dart';
import 'package:app/models/todo_model.dart';
import 'package:app/services/todo_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

todoCubit(context) => TodoCubit.get(context);

class TodoCubit extends Cubit<AppStates> {
  TodoCubit() : super(AppIntialState());

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
