import "dart:io";
void main(){

  for(int i = 1; i <= 5; i++){

    stdout.write(i);


  }
  print("");

  final numbers = <int>[13, 2, -11, 0];
  numbers.sort();
  print(numbers); // [-11, 0, 2, 13]


 
}

class MyClass with MixinClass1, MixinClass2 {

}

mixin MixinClass1{


  void hello1(){
    print("Hello 1");

  }
}

mixin MixinClass2{

  void hello2(){
    print("Hello 2");
  }
}

class ThemeManager {
  static final ThemeManager _instance = ThemeManager._internal();


  factory ThemeManager() {
    return _instance;
  }


  ThemeManager._internal(); // Private constructor
}

