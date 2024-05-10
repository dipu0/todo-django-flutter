import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todolist/domain/entity/todo_item.dart';
import 'package:todo/features/todolist/presentation/bloc/todos_bloc.dart';

class AddUpdateToDoScreen extends StatelessWidget {
  final ToDoItem? item;

  const AddUpdateToDoScreen({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController(text: item?.title ?? '');
    final TextEditingController descriptionController = TextEditingController(text: item?.description ?? '');
    bool isComplete = item?.complete ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(item == null ? 'Add ToDo' : 'Update ToDo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Complete: '),
                Checkbox(
                  value: isComplete,
                  onChanged: (value) {
                    isComplete = value!;
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _saveToDo(context, titleController.text, descriptionController.text, isComplete),
              child: Text(item == null ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveToDo(BuildContext context, String title, String description, bool isComplete) {
    if (title.isNotEmpty && description.isNotEmpty) {
      final newToDo = ToDoItem(
        title: title,
        description: description,
        created: DateTime.now().toString(),
        complete: isComplete,
      );

      if (item == null) {
        context.read<ToDosBloc>().add(AddToDoItem(newToDo));
      } else {
        context.read<ToDosBloc>().add(UpdateToDoItem(item!.id.toString(), newToDo));
      }
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a title and description')),
      );
    }
  }
}
