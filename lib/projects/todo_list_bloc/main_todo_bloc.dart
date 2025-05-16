import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App with BLoC',
      home: BlocProvider(create: (_) => TaskBloc(), child: const TodoScreen()),
    );
  }
}

// Task Model
class Task {
  final String description;
  final bool isDone;

  Task({required this.description, this.isDone = false});

  Task copyWith({String? description, bool? isDone}) {
    return Task(
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }
}

// BLoC Events
abstract class TaskEvent {}

class AddTask extends TaskEvent {
  final String description;

  AddTask(this.description);
}

class CompleteTask extends TaskEvent {
  final int index;

  CompleteTask(this.index);
}

// BLoC States
class TaskState {
  final List<Task> tasks;

  List<Task> get pendingTasks => tasks.where((task) => !task.isDone).toList();

  List<Task> get completedTasks => tasks.where((task) => task.isDone).toList();


  TaskState({this.tasks = const []});
}

// BLoC Implementation
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState()) {
    on<AddTask>((event, emit) {
      final updatedTasks = List<Task>.from(state.tasks)
        ..add(Task(description: event.description));
      emit(TaskState(tasks: updatedTasks));
    });

    on<CompleteTask>((event, emit) {
      final updatedTasks = List<Task>.from(state.tasks);
      updatedTasks[event.index] = updatedTasks[event.index].copyWith(
        isDone: true,
      );
      emit(TaskState(tasks: updatedTasks));
    });


  }
}

// UI Code
class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);
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
                    final title = controller.text.trim();
                    if (title.isNotEmpty) {
                      taskBloc.add(AddTask(title));
                      controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                final pendingTasks =
                    state.tasks.where((task) => !task.isDone).toList();
                return ListView.builder(
                  itemCount: pendingTasks.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(pendingTasks[index].description),
                      trailing: IconButton(
                        icon: const Icon(Icons.check_box_outline_blank),
                        onPressed: () {
                          final taskIndex = state.tasks.indexOf(
                            pendingTasks[index],
                          );
                          taskBloc.add(CompleteTask(taskIndex));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => BlocProvider.value(
                                    value: taskBloc,
                                    child: const CompletedTaskPage(),
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

class CompletedTaskPage extends StatelessWidget {
  const CompletedTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Completed Tasks')),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (BuildContext context, state) {
          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: const Checkbox(value: true, onChanged: null),
                title: Text(
                  state.tasks[index].description,
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
