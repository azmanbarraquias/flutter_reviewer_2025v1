import 'package:flutter/material.dart';

class AppService1 {
  AppService1() {
    debugPrint("AppService singleton instance is being created.");
  }

  String execute() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return date .toString().split(' ')[0];
  }
}




class AppService2 {
  AppService2() {
    debugPrint("AppService singleton instance is being created.");
  }

  String execute() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return date .toString().split(' ')[0];
  }
}

class AppService3 {
  AppService3() {
    debugPrint("AppService singleton instance is being created.");
  }

  String execute() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return date .toString().split(' ')[0];
  }
}