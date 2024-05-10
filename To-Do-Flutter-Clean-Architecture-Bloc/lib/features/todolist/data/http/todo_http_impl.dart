import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../../../core/core_export.dart';
import '../../domain/entity/todo_item.dart';
import '../../domain/repo/todo_repository.dart';
import '../model/item_list_response.dart';

class ToDoHttpImp extends BaseHttpRepository implements ToDoRepository {
  late final ApiClient _client;
  late final ToDoApiUrls _urls;

  ToDoHttpImp(this._client, this._urls) : super(_client);

  @override
  Future<Either<Failure, ToDoItemList>> getToDoList() async {
    try {
      final response = await _client.authorizedGet(_urls.getAllToDo);
      if (response.messageCode == 200) {
        ItemListResponse itemList =
            ItemListResponse.fromJson(response.response);

        List<ToDoItem> list = [];
        for (var item in itemList.data!) {
          list.add(ToDoItem(
             id: item.id, title: item.title, description: item.description, complete: item.complete, created: item.created
          ));

          Logger().i(item.title);
        }

        return Right(ToDoItemList(todoItems: list));
      } else {
        return const Left(ConnectionFailure("response.data['message']"));
      }
    } catch (e) {
      throw Future.error(e);
    }
  }

  Future<Either<Failure, ToDoItem>> addToDoItem(ToDoItem newItem) async {
    try {
      final response = await _client.authorizedPost(_urls.getAllToDo, newItem.toJson());

      if (response.messageCode == 200 || response.messageCode == 201) {
        final ToDoItem addedItem = ToDoItem.fromJson(response.response);

        Logger().i("Added new ToDo item: ${addedItem.title}");
        return Right(addedItem);
      } else {
        return Left(ConnectionFailure("Failed to add the new item. Error: ${response.message}"));
      }
    } catch (e) {
      Logger().e("Error adding new ToDo item: $e");
      throw Future.error(e);
    }
  }


  Future<Either<Failure, ToDoItem>> getToDoItem(String id) async {
    try {
      final response = await _client.authorizedGet(_urls.getAllToDo + '$id/');
      if (response.messageCode == 200) {
        final item = ToDoItem.fromJson(response.response);
        Logger().i(item.title);
        return Right(item);
      } else {
        return const Left(ConnectionFailure("Failed to fetch the item"));
      }
    } catch (e) {
      Logger().e("Error fetching ToDo item: $e");
      throw Future.error(e);
    }
  }
  Future<Either<Failure, ToDoItem>> updateToDoItem(String id, ToDoItem updatedItem) async {
    try {
      final response = await _client.authorizedPut(_urls.getAllToDo + '$id/', updatedItem.toJson() );
      if (response.messageCode == 200) {
        final item = ToDoItem.fromJson(response.response);
        Logger().i("Updated: ${item.title}");
        return Right(item);
      } else {
        return const Left(ConnectionFailure("Failed to update the item"));
      }
    } catch (e) {
      Logger().e("Error updating ToDo item: $e");
      throw Future.error(e);
    }
  }

  Future<Either<Failure, bool>> deleteToDoItem(String id) async {
    try {
      final response = await _client.authorizedDelete(_urls.getAllToDo + '$id/');
      if (response.messageCode == 200 || response.messageCode == 204) {
        Logger().i("Deleted ToDo item: $id");
        return const Right(true);
      } else {
        return const Left(ConnectionFailure("Failed to delete the item"));
      }
    } catch (e) {
      Logger().e("Error deleting ToDo item: $e");
      throw Future.error(e);
    }
  }

}
