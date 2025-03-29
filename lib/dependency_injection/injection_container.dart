import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/dependency_injection/app_service.dart';
import 'package:get_it/get_it.dart';

final locator1 = GetIt.instance;
final locator2 = GetIt.instance;
final locator3 = GetIt.instance;

void setup1() {
  debugPrint("setup1 is called");
  // created is called
  locator1.registerSingleton<AppService1>(AppService1());


}

void setup2() {
  debugPrint("setup2 is called");

  // Lazy singleton - created on use
  locator2.registerLazySingleton<AppService2>(() => AppService2());
}

void setup3() {
  debugPrint("setup3 is called");

  // when called always print new instance of AppService3
  locator3.registerFactory<AppService3>(() => AppService3());
}

void mainSetUp(){
  setup1();
  setup2();
  setup3();
}

