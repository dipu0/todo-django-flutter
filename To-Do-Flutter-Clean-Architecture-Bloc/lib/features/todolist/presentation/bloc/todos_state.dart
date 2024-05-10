part of 'todos_bloc.dart';

abstract class ToDosState extends Equatable {
  const ToDosState();
}

class ToDosInitial extends ToDosState {
  @override
  List<Object> get props => [];
}

class ToDosLoading extends ToDosState {
  @override
  List<Object> get props => [];
}

class ToDosLoaded extends ToDosState {
  final List<ToDoItem> todos;

  const ToDosLoaded(this.todos);

  @override
  List<Object> get props => [todos];
}

class ToDosError extends ToDosState {
  final String message;

  const ToDosError(this.message);

  @override
  List<Object> get props => [message];
}

class ToDoItemAdded extends ToDosState {
  @override
  List<Object?> get props => [];
}

class ToDoItemUpdated extends ToDosState {
  @override
  List<Object?> get props => [];
}

class ToDoItemDeleted extends ToDosState {
  @override
  List<Object?> get props => [];
}
