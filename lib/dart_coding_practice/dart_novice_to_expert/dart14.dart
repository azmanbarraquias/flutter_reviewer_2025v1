// #14 - Dart Control Flow Statements - if/else, for, while, switch, throw, catch + ENUMS & EXCEPTIONS
// https://www.youtube.com/watch?v=uVo1nDySzO4&list=PLptHs0ZDJKt_fLp8ImPQVc1obUJKDSQL7&index=15
// dart

void main() {
  var num = List.generate(10, (index) => index);
  num.forEach(print);
}
void main1(){


  print('hello');
  print('hello');
  print('hello');
  print('hello');
  print('hello');
  print('hello');
  print('hello');
  print('hello');
  hello(5);
  print('hello');
  print('hello');
  print('hello');
  print('hello');
  print('hello');
  print('hello');
  print('hello');
  print('hello');
  print('hello');

  if (true) {
    print('hello');
  } else {
    print('bye');
  }

  var a = 5;
  a.isEven ? print('even') : print('odd');

  var numList = [1,2,3,4,5].where((e) => e.isEven);
  for(var i = 0; i < numList.length; i++){
    print('x $i');
  }

  for(var num in numList){
    print('y $num');
  }

  numList.forEach((num){
    print('s $num');
  });

  numList.forEach(print);

  var i = 0;
  while(i < 5) {
    print('while');
    i++;
  }

  do {
    print('do while');
  } while(false);

}

void hello(int a) {
  for (int i = 0; i < a; i++) {
    print('hello $i');

  }
}