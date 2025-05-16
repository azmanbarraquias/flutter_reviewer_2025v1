import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/utils/xprint.dart';

import '../provider/todo_list.dart';
import 'completed_task_page.dart';
import 'package:provider/provider.dart';

class MyTodoPage extends StatefulWidget {
  const MyTodoPage({super.key});

  @override
  State<MyTodoPage> createState() => _MyTodoPageState();
}

class _MyTodoPageState extends State<MyTodoPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final toDoList = Provider.of<TodoList>(context, listen: false);
    xPrint('_MyTodoPageState rebuild');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('My ToDo'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Consumer<TodoList>(
                builder: (BuildContext context, TodoList value, Widget? child) {
                  xPrint(' Consumer<TodoList> rebuild');
                  return ListView.builder(
                    itemCount: value.pendingTask.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(value.pendingTask[index].description),
                        trailing: Checkbox(
                          value: value.pendingTask[index].isCompleted,
                          onChanged: (value) => onTaskComplete(index),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(color: Colors.black, height: 1),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(hintText: 'Enter Task'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (controller.text.isEmpty) {
                        return;
                      }
                      toDoList.addTask(controller.text);
                      controller.clear();
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTaskComplete(int index) {
    Provider.of<TodoList>(context, listen: false).markTaskCompleted(index);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CompletedTaskPage()),
    );
  }
}
