import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todolist/domain/entity/todo_item.dart';
import 'package:todo/features/todolist/domain/usecase/todos_use_case.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class ToDosBloc extends Bloc<ToDosEvent, ToDosState> {

  final ToDosUseCase _todosUseCase;

  ToDosBloc(this._todosUseCase) : super(ToDosInitial()) {
    on<FetchToDos>(_fetchToDos);
    on<FetchToDoItem>(_fetchToDoItem);
    on<UpdateToDoItem>(_updateToDoItem);
    on<DeleteToDoItem>(_deleteToDoItem);
    on<AddToDoItem>(_addToDoItem);
  }

  _fetchToDos(ToDosEvent event, Emitter<ToDosState> emit,) async {
    emit(ToDosLoading());

    try {
      final ToDos = await _todosUseCase.getToDoList();

      ToDos.fold(
            (failure) {
          emit(ToDosError(failure.message));
        },
            (todos) {
          print("ToDosLoaded: ${todos.todoItems}");
          emit(ToDosLoaded(todos.todoItems!));
        },
      );

      //emit(ToDosLoaded(ToDos.rig));
    } catch (error) {
      emit(ToDosError(error.toString()));
    }
  }

  Future<void> _fetchToDoItem(FetchToDoItem event,
      Emitter<ToDosState> emit) async {
    emit(ToDosLoading());
    final result = await _todosUseCase.getToDoItem(event.id);
    result.fold(
          (failure) => emit(ToDosError(failure.message)),
          (item) => emit(ToDosLoaded([item])),
    );
  }

  Future<void> _updateToDoItem(UpdateToDoItem event,
      Emitter<ToDosState> emit) async {
    emit(ToDosLoading());
    final result = await _todosUseCase.updateToDoItem(event.id, event.item);
    result.fold(
          (failure) => emit(ToDosError(failure.message)),
          (_) => add(FetchToDos()),
    );
  }

  Future<void> _deleteToDoItem(DeleteToDoItem event,
      Emitter<ToDosState> emit) async {
    emit(ToDosLoading());
    final result = await _todosUseCase.deleteToDoItem(event.id);
    result.fold(
          (failure) => emit(ToDosError(failure.message)),
          (_) => add(FetchToDos()),
    );
  }

Future<void> _addToDoItem(AddToDoItem event, Emitter<ToDosState> emit) async {
  emit(ToDosLoading());
  final result = await _todosUseCase.addToDoItem(event.item);
  result.fold(
        (failure) => emit(ToDosError(failure.message)),
        (_) => add(FetchToDos()),
  );
}
}