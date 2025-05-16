import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/todo_list.dart';

class CompletedTaskPage extends StatelessWidget {
  const CompletedTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Consumer<TodoList>(
          builder: (BuildContext context, value, Widget? child) {
            return ListView.builder(
              itemCount: value.completedTask.length,
              itemBuilder: (ctx, i) {
                return ListTile(
                  title: Text(
                    value.completedTask[i].description,
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                  trailing: Checkbox(
                    fillColor: WidgetStateProperty.all(Colors.black54),
                    value: true,
                    onChanged: (value) {
                      return;
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
