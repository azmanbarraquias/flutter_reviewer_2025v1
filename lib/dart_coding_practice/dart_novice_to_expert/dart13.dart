// #13 - Dart Operators - Everything you need to know + Comparing 2 Objects in Dart
// https://www.youtube.com/watch?v=UKyKGwyls_I&list=PLptHs0ZDJKt_fLp8ImPQVc1obUJKDSQL7&index=14
import 'package:equatable/equatable.dart';
import 'dart:math' as math;

void main() {
  int? a;
  int? b;
  print(a);
  a ??= 5;
  print(a);

  print('1. ${b ?? 5}');
  print(b);
  print(b ??= 5);
  print(b);
}

void func() {
  var a = const A(1);
  var b = const B(2);

  //? a.+b
  print(a + b);

  //? b.+a
  print(a + b);

  print(b + b);
  print(a + a);

  print(identical(a, b));

  var c = C();
  var d = C();
  print(c == d);

  var e = const D(1, 2);
  var f = const D(1, 2);
  print(e == f);

  var g = const E(1, 2);
  var h = const E(1, 2);
  print(g == h);
}

class X {
  final int value;

  const X(this.value);
}

class A extends X {
  const A(int value) : super(value);

  String operator +(X other) => 'A() => ${value + other.value}';
}

class B extends X {
  const B(super.value);

  String operator +(X other) => 'B() => ${value + other.value}';
}

class C {
  int a = 2;
  int b = 2;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is C && other.a == a && other.b == b;
  }

  @override
  int get hashCode => a.hashCode ^ b.hashCode;
}

class D {
  final int a;
  final int b;

  const D(this.a, this.b);
}

class E extends Equatable {
  final int a;
  final int b;

  const E(this.a, this.b);

  @override
  List<Object?> get props => [a, b];
}
