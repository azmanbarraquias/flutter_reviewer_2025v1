import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/projects/my_todo_list_provider/page/my_todo_page.dart';
import 'package:flutter_reviewer_2025v1/projects/my_todo_list_provider/provider/todo_list.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TodoList())],
      child: MaterialApp(
        title: 'My ToDo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyTodoPage(),
      ),
    );
  }
}
