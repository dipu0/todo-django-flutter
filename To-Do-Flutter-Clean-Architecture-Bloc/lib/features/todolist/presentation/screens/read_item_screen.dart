import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/todo_item.dart';
import '../bloc/todos_bloc.dart';
import 'add_update_todo_screen.dart';

class ReadItemScreen extends StatelessWidget {
  final ToDoItem item;

  const ReadItemScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${item.title}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Description: ${item.description}'),
            SizedBox(height: 10),
            Text('Created: ${item.created}'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _navigateToUpdate(context, item),
                  child: Text('Update'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(item.complete! ? Colors.red : Colors.green),
                  ),
                  onPressed: () => _toggleCompleteStatus(context, item),
                  child: Text(item.complete! ? 'Mark as Incomplete' : 'Mark as Complete'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                  ),
                  onPressed: () => _confirmDelete(context, item),
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
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

  void _toggleCompleteStatus(BuildContext context, ToDoItem item) {
    // Create a copy of the item with the toggled completion status
    final updatedItem = item.copyWith(complete: !item.complete!);
    // Dispatch update event to Bloc
    context.read<ToDosBloc>().add(UpdateToDoItem(item.id.toString(), updatedItem));

    Navigator.of(context).pop();
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
              onPressed: () => Navigator.of(context).pop(),
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
    Navigator.of(context).pop(); // Close the detail screen after deletion
  }
}
