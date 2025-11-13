// Dart Classes Explained I - All Fields, Methods, Constructors, Operators, Getters/Setters & Singleton
// https://www.youtube.com/watch?v=7rfehxYBukk&list=PLptHs0ZDJKt_fLp8ImPQVc1obUJKDSQL7&index=16

// Instance variable
// - method

// ? instance <=> field
import 'dart:math' as math;

class A {
  A();

  int? a;
}

void main() {
  // var a1 = A();
  // a1
  //   ..a = 3
  //   ..a = 4
  //   ..a = 5;
  //
  // print(a1.a);

  var b1 = B(1, 2, 3, 4, 5, e: 6, f: 7);
  print(b1._private);
  print(b1.a);
  print(b1.b);
  print(b1.c);
  print(b1.d);
  print(b1.e);
  print(b1.f);

  var c1 = C(x: 1, y: 2);
  var c2 = C.zero();
  var c3 = C.fromJson(json: {'x': 1, 'y': 2});
  var c4 = C.zeroX(y: 2);
  var c5 = C.zeroY(x: 1);
  var c6 = C.zeroXX(y: 2);
  var c7 = C.zeroYY(x: 1);
  var c8 = C.randomPoint(isPositive: true);
  var c9 = C.randomPoint(isPositive: false);
  var d1 = D(x: 1, y: 2);
  var d2 = D.zeroX(y: 2);
  var d3 = D.zeroY(x: 1);

  print(c1.x);
  print(c1.y);
  print(c2.x);
  print(c2.y);
  print(c3.x);
  print(c3.y);
  print(c4.x);
  print(c4.y);
  print(c5.x);
  print(c5.y);
  print(c6.x);
  print(c6.y);
  print(c7.x);
  print(c7.y);
  print(c8.x);
  print(c8.y);
  print(c9.x);
  print(c9.y);
  print(d1.x);
  print(d1.y);
  print(d2.x);
  print(d2.y);
  print(d3.x);

  var s1 = SingletonX();
  var s2 = SingletonX();
  print(s1 == s2);
  print(SingletonX.random);
  SingletonX.name = "Bob";

}

class B {
  int _private;
  int a;
  int b;
  int c;
  int? d;
  int? e;
  final int f;

  B(int p, int a, int b, this.c, int d, {int? e, required this.f})
    : _private = p,
      this.a = a,
      b = b,
      e = e {
    this.d = d;
  }
}

class C {
   int x;
   int y;
  C({required this.x, required this.y});

  C.zero() : x = 0, y = 0;

  C.fromJson({required Map<String, int> json}) : x = json['x']!, y = json['y']!;

  C.zeroX({required y}) : this(x: 0, y: y);
  C.zeroY({required x}) : this(x: x, y: 0);

  C.zeroXX({required this.y}) : x = 0;
  C.zeroYY({required this.x}) : y = 0;

  factory C.randomPoint({required bool isPositive}) {
    var x = isPositive ? math.Random().nextInt(100) : -math.Random().nextInt(100);
    var y = isPositive ? math.Random().nextInt(100) : -math.Random().nextInt(100);
    return C(x: x, y: y);
  }
}

class SingletonX {
  SingletonX._privateConstructor();
  static final SingletonX _instance = SingletonX._privateConstructor();
  factory SingletonX() => _instance;

  // return random number
  static int get random => math.Random().nextInt(100);

  // get set example
  static String? _name;
  static String? get name => _name;
  static set name(String? value) => _name = value;
}

class D {
  final int x;
  final int y;
  D({required this.x, required this.y}) {
    print('Main constructor: $x $y');
  }

  D.zeroX({required y}) : this(x: 0, y: y);
  D.zeroY({required x}) : this(x: x, y: 0);

  D.zeroXX({required this.y}) : x = 0;
  D.zeroYY({required this.x}) : y = 0;
}
