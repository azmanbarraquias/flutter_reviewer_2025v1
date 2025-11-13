// #9 - Understanding Null Safety in Dart - Type Promotions, Null Assertion, Late, Required

// It is unsafe to have one or multiple null values flow untracked in an application
// Errors related to the safety of null should be shown at edit-time, and not at run time, where it may be too late.

// Sound null safety
// - not having null, where you don't expect them

// throws null reference errors, if you're using null safety, with no explicitly unsafe features

void main() {
  var c = Car();
  c.brake();
  c.accelerate(); // error final variable already assign.
  print(c.speed);
}

class Car {
  late final int speed;

  void accelerate() {
    speed = 10;
  }

  void brake() {
    speed = 0;
  }
}

void foo() {}
