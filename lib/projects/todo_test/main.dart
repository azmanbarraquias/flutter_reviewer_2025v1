import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple To-Do',
      home: TodoScreen(),
    );
  }
}

class Task {
  String title;
  bool isDone;
  Task({required this.title, this.isDone = false});
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Task> tasks = [];
  final TextEditingController controller = TextEditingController();

  void _addTask(String title) {
    if (title.isNotEmpty) {
      setState(() {
        tasks.add(Task(title: title));
        controller.clear();
      });
    }
  }

  void _markTaskCompleted(int index) {
    setState(() {
      tasks[index].isDone = true;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CompletedTasksScreen(
          completedTasks: tasks.where((task) => task.isDone).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pendingTasks = tasks.where((task) => !task.isDone).toList();

    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(hintText: 'Enter task'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addTask(controller.text),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pendingTasks.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(pendingTasks[index].title),
                  trailing: IconButton(
                    icon: Icon(Icons.check_box_outline_blank),
                    onPressed: () {
                      int originalIndex = tasks.indexOf(pendingTasks[index]);
                      _markTaskCompleted(originalIndex);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CompletedTasksScreen extends StatelessWidget {
  final List<Task> completedTasks;

  const CompletedTasksScreen({super.key, required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Completed Tasks')),
      body: ListView.builder(
        itemCount: completedTasks.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: Checkbox(value: true, onChanged: null),
            title: Text(
              completedTasks[index].title,
              style: TextStyle(decoration: TextDecoration.lineThrough),
            ),
          );
        },
      ),
    );
  }
}
