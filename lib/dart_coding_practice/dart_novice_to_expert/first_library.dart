library first_library;

import 'dart:math';

part 'second_library.dart';

class AF {
  final int _privateField = 5;
  void _privateMethod(){

  }

  final int publicField = 10;
  void publicMethod() {

  }
}

class RandomClass {
  void Test(){
    AF af = AF();
    af._privateField;
    af._privateMethod();

    af.publicField;
    af.publicMethod();

  }
}
void afFunction() {
  //random number
  print('RandomNum: ${Random().nextInt(100)}');
  BF bf = BF();
  bf._privateField;

}


