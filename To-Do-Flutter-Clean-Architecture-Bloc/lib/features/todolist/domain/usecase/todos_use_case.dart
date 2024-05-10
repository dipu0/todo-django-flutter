import 'package:dartz/dartz.dart';
import 'package:todo/features/todolist/domain/entity/todo_item.dart';

import '../../../../core/core_export.dart';
import '../repo/todo_repository.dart';


class ToDosUseCase {
  final ToDoRepository _todoRepository;

  ToDosUseCase(this._todoRepository);

  Future<Either<Failure, ToDoItemList>> getToDoList() async {
    return await _todoRepository.getToDoList();
  }

  Future<Either<Failure, ToDoItem>> addToDoItem(ToDoItem newItem) async{
   return await _todoRepository.addToDoItem(newItem);
  }
  Future<Either<Failure, ToDoItem>> getToDoItem(String id) async{
    return await _todoRepository.getToDoItem(id);
  }
  Future<Either<Failure, ToDoItem>> updateToDoItem(String id, ToDoItem updatedItem) async{
    return await _todoRepository.updateToDoItem(id, updatedItem);
  }
  Future<Either<Failure, bool>> deleteToDoItem(String id) async {
    return await _todoRepository.deleteToDoItem(id);
  }
}
