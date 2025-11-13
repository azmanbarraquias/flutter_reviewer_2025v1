// #21 - Dart Synchronous Workflows, Iterables, sync* generator functions, yield, yield*
// https://www.youtube.com/watch?v=60UdftkluF8&list=PLptHs0ZDJKt_fLp8ImPQVc1obUJKDSQL7&index=22

import 'dart:io';

void main () {
  // sum(1, 2);
  // print('sum1(1, 2) ---> ${sum(1, 2)}');
  // print('A');
  // print('show() ---> ${show1()}');
  // print('B');

  // print('showNormal() ---> ${showNormal()}');
  // final b = showNormal();

  final a = showGenerator(); // will not generate if not use
  print(a.last);
  // print(a);

  // final iterable = Iterable.generate(10, (i) {
  //   print(i);
  //   return i;
  // });
  // iterable.elementAt(9);

}

int sum(int a, int b) => a + b;

Iterable<int> showGenerator() sync* {
  print('Generator Started');
  for (var i = 0; i < 10; i++) {
    print('Generator $i');
    yield i;
  }
  yield* showNegative();

  print('Generator Ended');

}

Iterable<int> showNegative() sync*{
  print('-Generator Started');
  for (var i = 0; i < 10; i++) {
    print('Generator ${-i}');
    yield -i;
  }
  print('-Generator Ended');
}


List<int> showNormal() {
  print('Normal Started');
  final list = <int>[];
  for (var i = 0; i < 10; i++) {
    print('Normal $i');
    list.add(i);
  }
  print('Normal Ended');
  return list;
}

