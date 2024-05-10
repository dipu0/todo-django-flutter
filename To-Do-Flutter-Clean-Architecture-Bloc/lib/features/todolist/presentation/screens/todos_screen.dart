import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todolist/domain/entity/todo_item.dart';
import 'package:todo/features/todolist/presentation/screens/read_item_screen.dart';
import '../bloc/todos_bloc.dart';
import 'add_update_todo_screen.dart';

class ToDosScreen extends StatelessWidget {
  const ToDosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ToDosBloc>().add(const FetchToDos());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your ToDos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: BlocConsumer<ToDosBloc, ToDosState>(
          listener: (context, state) {
            if (state is ToDosError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('An error occurred')),
              );
            }
          },
          builder: (context, state) {
            if (state is ToDosLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ToDosLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ToDosBloc>().add(const FetchToDos());
                },
                child: _listView(context, state.todos),
              );
            } else {
              return const Center(child: Text('No todos found.', style: TextStyle(fontSize: 18)));
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _navigateToAdd(context);
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Todo'),
          backgroundColor: Colors.deepPurple,
        ),
      ),
    );
  }

  Widget _listView(BuildContext context, List<ToDoItem> todoItems) {
    return ListView.builder(
      itemCount: todoItems.length,
      itemBuilder: (context, index) {
        final item = todoItems[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 8,
            shadowColor: Colors.deepPurpleAccent,
            child: ListTile(
              leading: Icon(Icons.check_circle_outline, color: item.complete! ? Colors.green : Colors.red),
              title: Text(item.title ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Tap for details', style: TextStyle(color: Colors.deepPurpleAccent)),
              onTap: () => _navigateToDetails(context, item),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _navigateToUpdate(context, item);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _confirmDelete(context, item);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToAdd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUpdateToDoScreen(),
      ),
    );
  }

  void _navigateToUpdate(BuildContext context, ToDoItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUpdateToDoScreen(item: item),
      ),
    );
  }

  void _navigateToDetails(BuildContext context, ToDoItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReadItemScreen(item: item),
      ),
    );
  }

  void _confirmDelete(BuildContext context, ToDoItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this item?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteItem(context, item);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(BuildContext context, ToDoItem item) {
    context.read<ToDosBloc>().add(DeleteToDoItem(item.id.toString()));
  }
}
