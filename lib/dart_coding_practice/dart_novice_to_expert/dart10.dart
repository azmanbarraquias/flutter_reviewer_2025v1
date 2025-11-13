// #10 - Dart Variables and the differences between Late, Var, Dynamic, Final & Const

// Top variable / global variable
// static / instance variable
// local variable base on scope {}

import 'dart:math';

import 'package:flutter_reviewer_2025v1/utils/xprint.dart';

class A {
  static late final int? temp;
}

void main() {
  var b1 = const B(nums: [1, 2, 3, 4]);
  var b2 = const B(nums: [1, 2, 3, 4]);
  xPrint(b1 == b2);
  xPrint(b1.hashCode);
  xPrint(b2.hashCode);
}

class B {
  final List<int> nums;

  const B({required this.nums});
}
