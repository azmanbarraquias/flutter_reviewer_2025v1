import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'simple_logger_helper.dart';
import 'my_page.dart';

// --- App Lifecycle Observer Class ---
class MyAppLifecycleLogger with WidgetsBindingObserver {
  void start() {
    WidgetsBinding.instance.addObserver(this);
  }

  void stop() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    SimpleLogger.writeLog('AppLifecycle $state at ${DateTime.now()}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ensureStoragePermission();
  runApp(const MyApp());
}

Future<bool> ensureStoragePermission() async {
  var statusManage = await Permission.manageExternalStorage.status;
  if (!statusManage.isGranted) {
    statusManage = await Permission.manageExternalStorage.request();
  }
  return statusManage.isGranted;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyPage(),
  );
}



