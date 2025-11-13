// #12 - Dart Functions - Anonymous Functions, Positional & Named Parameters, Lambdas, Closures, Scope
// https://www.youtube.com/watch?v=xL_uC8qm2L4&list=PLptHs0ZDJKt_fLp8ImPQVc1obUJKDSQL7&index=13

void main() {
 A()();
}

void second(int Function(int) f, int a) {
  print(f.call(a));
  print(f(a));
}

int first(int a) {
  return a;
}

class A {
  void call() => print("I'm a function");
}