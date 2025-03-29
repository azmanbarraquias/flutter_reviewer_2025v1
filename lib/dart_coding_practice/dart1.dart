
void main(){
  var myclass = MyClass();
  myclass.hello1();
  myclass.hello2();


 
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

