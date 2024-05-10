part of 'todos_bloc.dart';


abstract class ToDosEvent extends Equatable {
  const ToDosEvent();
}

class FetchToDos extends ToDosEvent {
  const FetchToDos();

  @override
  List<Object> get props => [];
}

class FetchToDoItem extends ToDosEvent {
  final String id;

  const FetchToDoItem(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateToDoItem extends ToDosEvent {
  final String id;
  final ToDoItem item;

  const UpdateToDoItem(this.id,this.item);

  @override
  List<Object> get props => [item];
}

class DeleteToDoItem extends ToDosEvent {
  final String id;

  const DeleteToDoItem(this.id);

  @override
  List<Object> get props => [id];
}


class AddToDoItem extends ToDosEvent {
  final ToDoItem item;

  const AddToDoItem(this.item);

  @override
  List<Object> get props => [item];
}
