import 'package:dartz/dartz.dart';
import 'package:todo/core/core_export.dart';

import '../entity/todo_item.dart';

abstract class ToDoRepository {
  Future<Either<Failure, ToDoItemList>> getToDoList();
  Future<Either<Failure, ToDoItem>> addToDoItem(ToDoItem newItem);
  Future<Either<Failure, ToDoItem>> getToDoItem(String id);
  Future<Either<Failure, ToDoItem>> updateToDoItem(String id, ToDoItem updatedItem);
  Future<Either<Failure, bool>> deleteToDoItem(String id);

}
