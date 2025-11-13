// https://www.youtube.com/watch?v=OThpFGSzV1g&list=PLptHs0ZDJKt_fLp8ImPQVc1obUJKDSQL7&index=17
// Dart Classes Explained II - Inheritance(extends) vs. Abstraction(implements) vs. Mixins(with)
// Contract

import 'dart:math';

void main() {
  // var birC = BirdC(name: 'Parrot');
  // birC.wingColor();
  //
  // var mouse = Mouse();
  // var cat = Cat();
  // cat.chase(mouse);
  // mouse.doSomething();

  var musician = Musician();
  musician.test();
  print(2.square);
  print(2.cube);
  print(2.decimal); // 3.0
}

extension IntergerExtension on int {
  int get square => this * this;

  int get cube => this * this * this;

  double get decimal => toDouble(); // Just call the built-in method!
}

class Animal {
  final String name;

  Animal({required this.name});

  void whatAmI() => print(name);

  void chase(Animal animal) => print("$name is chasing ${animal.name}");

  external void doSomething();
}

class BirdP extends Animal {
  BirdP({required super.name});

  void wingColor() => print("The wing color is black");
}

class BirdC extends BirdP {
  BirdC({required name}) : super(name: name);

  @override
  void wingColor() => print("The wing color is White");
}

class Mouse extends Animal {
  Mouse({super.name = 'Jerry'});

  @override
  void doSomething({String name = 'Tom'}) {
    print('$name is doing something');
  }
}

class Cat extends Animal {
  Cat() : super(name: 'Tom');

  @override
  void chase(covariant Mouse m) => print("This cat is chasing ${m.name}");
}

// Abstraction
abstract class UserRepositoryInterface {
  late final List<int> userList;

  void create();

  List<int> read();

  void update();

  void delete();
}

class User implements UserRepositoryInterface {
  @override
  late List<int> userList;

  @override
  void create() {
    userList.add(Random().nextInt(100));
  }

  @override
  void delete() {
    if (userList.isNotEmpty) {
      userList.removeLast();
    }
  }

  @override
  List<int> read() {
    return List.generate(5, (i) => i);
  }

  @override
  void update() {}
}

class A {
  void methodA() {}
}

class B {
  void methodB() {}
}

class C {
  void methodC() {}
}

class D extends Animal implements A, B, C {
  D({required super.name});

  @override
  void methodA() {
    // TODO: implement methodA
  }

  @override
  void methodB() {
    // TODO: implement methodB
  }

  @override
  void methodC() {
    // TODO: implement methodC
  }

  @override
  void doSomething() {
    // TODO: implement doSomething
  }
}

// Mixin
mixin AMix {
  void methodA() {}

  void methodB() {}

  void methodC() {}
}

class Performer {
  void perform() {
    print("I am performing");
  }
}

mixin Drummer {
  void perform() {
    print("I am performing with a drum");
  }

  void playDrum() {
    print("I am playing a drum");
  }
}

mixin Guitar {
  void perform() {
    print("I am performing with a guitar");
  }

  void playGuitar() {
    print("I am playing a guitar");
  }
}

mixin Violist on Performer {
  void test() {
    perform();
  }

  void playViolin() {
    print("I am playing a violin");
  }
}

class Musician extends Performer with Guitar, Drummer, Violist {}
