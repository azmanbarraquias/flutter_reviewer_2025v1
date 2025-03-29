import 'package:flutter/material.dart';
import 'app_service.dart';
import 'injection_container.dart';

void main() {
  mainSetUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String date = "0";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Text(date),
          OutlinedButton(
            onPressed: () {
              String currentDate = locator1<AppService1>().execute();
              setState(() {
                date = currentDate;
              });
            },
            child: Text("registerSingleton"),
          ),
          OutlinedButton(
            onPressed: () {
              String currentDate = locator2<AppService2>().execute();
              setState(() {
                date = currentDate;
              });
            },
            child: Text("registerLazySingleton"),
          ),
          OutlinedButton(
            onPressed: () {
              String currentDate = locator3<AppService3>().execute();
              setState(() {
                date = currentDate;
              });
            },
            child: Text("registerFactory"),
          ),
          OutlinedButton(
            onPressed: () {
              setState(() {
                date = "";
              });
            },
            child: Text("Clear"),
          ),
        ],
      ),
    );
  }
}
