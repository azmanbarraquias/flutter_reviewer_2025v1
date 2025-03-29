import 'package:flutter/material.dart';

void main(){
  var p = Person();
  Person.veryOld();

}


class Person {

  Person();

  Person.veryOld(){
  }
}

class Test123 extends StatelessWidget {
  const Test123({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
