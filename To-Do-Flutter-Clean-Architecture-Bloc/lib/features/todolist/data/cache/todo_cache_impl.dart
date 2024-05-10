import 'package:dartz/dartz.dart';
import 'package:todo/features/trades/data/http/trade_http_impl.dart';

import '../../../../core/core_export.dart';
import '../../domain/entity/todo_item.dart';
import '../../domain/repo/todo_repository.dart';
import '../http/todo_http_impl.dart';

class ToDoCacheImpl extends BaseCacheRepository implements ToDoRepository {
  static const cacheKey = "project:todos";

  final ToDoHttpImp _todoHttpImp;

  ToDoCacheImpl(BaseCache cache, this._todoHttpImp) : super(cache);

  @override
  Future<Either<Failure, ToDoItemList>> getToDoList() async {
    String? value = await cache.get(cacheKey);
    if (value == null) {
      return _getFromSourceAndSave();
    }

    return Right(ToDoItemList.fromJson(value));
  }

  Future<Either<Failure, ToDoItemList>> _getFromSourceAndSave() async {
    Either<Failure, ToDoItemList> todos = await _todoHttpImp.getToDoList();

    if (todos.isRight()) {
      ToDoItemList? todosList = todos.fold((l) => null, (r) => r);
      cache.put(cacheKey, todosList!.toJson(), const Duration(days: 1));
    }

    return todos;
  }

  @override
  Future<Either<Failure, bool>> deleteToDoItem(String id) {
    // TODO: implement deleteToDoItem
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ToDoItem>> getToDoItem(String id) {
    // TODO: implement getToDoItem
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ToDoItem>> updateToDoItem(String id, ToDoItem updatedItem) {
    // TODO: implement updateToDoItem
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ToDoItem>> addToDoItem(ToDoItem newItem) {
    // TODO: implement addToDoItem
    throw UnimplementedError();
  }

}
