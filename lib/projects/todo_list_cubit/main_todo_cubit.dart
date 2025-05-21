import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple To-Do',
      home: BlocProvider(create: (_) => TaskCubit(), child: const TodoScreen()),
    );
  }
}

// Task Model
class Task {
  String description;
  bool isDone;

  Task({required this.description, this.isDone = false});

  Task copyWith({String? description, bool? isDone}) {
    return Task(
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }
}

// Cubit
class TaskCubit extends Cubit<List<Task>> {
  TaskCubit() : super([]);

  void addTask(String description) {
    if (description.isNotEmpty) {
      final updatedTasks = List<Task>.from(state);
      updatedTasks.add(Task(description: description));
      emit(updatedTasks);
    }
  }

  void markTaskCompleted(int index) {
    final updatedTasks = List<Task>.from(state);
    updatedTasks[index].isDone = true;
    emit(updatedTasks);
  }

  List<Task> get pendingTasks => state.where((task) => !task.isDone).toList();

  List<Task> get completedTasks => state.where((task) => task.isDone).toList();
}

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(hintText: 'Enter task'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    context.read<TaskCubit>().addTask(controller.text);
                    controller.clear();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TaskCubit, List<Task>>(
              builder: (context, tasks) {
                final pendingTasks = context.read<TaskCubit>().pendingTasks;
                return ListView.builder(
                  itemCount: pendingTasks.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(pendingTasks[index].description),
                      trailing: IconButton(
                        icon: const Icon(Icons.check_box_outline_blank),
                        onPressed: () {
                          int originalIndex = tasks.indexOf(
                            pendingTasks[index],
                          );
                          context.read<TaskCubit>().markTaskCompleted(
                            originalIndex,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => BlocProvider.value(
                                    value: context.read<TaskCubit>(),
                                    child: const CompletedTasksScreen(),
                                  ),
                            ),
                          );
                        },
                      ),
                    );
                  },
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
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final completedTasks = context.read<TaskCubit>().completedTasks;
    return Scaffold(
      appBar: AppBar(title: const Text('Completed Tasks')),
      body: BlocBuilder<TaskCubit, List<Task>>(
        builder:
            (context, tasks) => ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: const Checkbox(value: true, onChanged: null),
                  title: Text(
                    completedTasks[index].description,
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                );
              },
            ),
      ),
    );
  }
}
