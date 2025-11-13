// #20 - Dart Isolates, Threads, The Event Loop, Microtasks, Synchronous & Asynchronous workflows
// https://www.youtube.com/watch?v=ArbJhSsEwTk&list=PLptHs0ZDJKt_fLp8ImPQVc1obUJKDSQL7&index=21

void main() {
  test2();
}

void test1 () {
  print('A');
  Future(() {
    print('B');
    Future(()=> print('C'));
    Future(()=> print('D'));
    Future(()=> print('E'));
    print('F');
  });
  print('G');
}

void test2 () {
  print('A');
  Future(() {
    print('B');
    Future(()=> print('C'));
    Future.microtask (()=> print('D'));
    Future(()=> print('E'));
    print('F');
  });
  print('G');
}