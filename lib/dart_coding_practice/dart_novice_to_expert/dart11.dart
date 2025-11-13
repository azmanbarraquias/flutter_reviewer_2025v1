// #11 - Dart Built-in Types - num, int, double, String, List, Set, Map & Runes

import 'dart:ffi';

void main() {
  var gen = [
    ...List.generate(2, (index) => index) + [3, 4, 5],
  ];
  var gen2 = {
    ...List.generate(6, (index) => index).toSet(),
    ...{3, 4, 5},
  };
  print(gen);
  print(gen2);
  functionRunes();
}

void function2() {
  Set<String> set = {'a', 'b', 'c'};
  var numSet = {1, 2, 3};
  numSet.add(1);
  print(numSet);
  var newSet = {...set, ...numSet};

  var map = {1: 'a', 2: 'b', 3: 'c'};
}

void functionRunes() {
  var runes = Runes('Hello').map((e) => String.fromCharCode(e));
  var runes1 = Runes('Hello').map((e) => e.toRadixString(16).padLeft(4, '0')).toList();
  print(runes);
  print(runes1);
  var runes3 = '\u{0048}\u{0065}\u{006c}\u{006c}\u{006f}';
  print(runes3);
  print('\u{1F339}');
}

void functionMap() {
  var map = {1: 'a', 2: 'b', 3: 'c'};
   var map2 = {...map, 4: 'd'};
   map2.addAll({5: 'e'});
   map2.addEntries([MapEntry(6, 'f'), MapEntry(7, 'g')]);
   map2.remove(1);
   map2.removeWhere((key, value) => key % 2 == 0);
   print(map2);
  map2.forEach((key, value) {
    print('$key: $value');
  });
}

void function1() {
  List<num> numbers = [1, 2, 3, 4, 5];
  num a = 5;
  int b = 5;
  double c = 5.0;
  var d = 5.0;
  dynamic e = 5.0;
  print(a.hashCode);
  print(b.hashCode);
  print(c.hashCode);
  print(d.hashCode);
  print(e.hashCode);
  print(numbers[4].hashCode);

  var aClass = A();
  print(aClass.a.hashCode);
  print(A.b.hashCode);

  num tempNum = -15.55;

  print(tempNum.clamp(-1, 3));
  print(tempNum.ceil());
  print(tempNum.floor());
  print(tempNum.round());

  String str =
      'hello'
      ' '
      'world';
  print(str);

  print('emoji \u{1F330}');

  // regex ph phone number
  var phoneRegex = RegExp(r'^[0-9]{3}[0-9]{3}[0-9]{4}$');
  var phone = '1234567890';
  print(phoneRegex.hasMatch(phone));

  bool isTrue = false;
  print(isTrue ? true : false);

  List<int> list1 = List.generate(4, (index) => index + 1);

  List<int> list = [1, 2, 3, 4, 5];
  List<int> list2 = [...list, 6, 7, 8, 9, 10];
  print(list2.where((element) => element % 2 == 0));
  print(list2.where((element) => element.isOdd));
  print(list1);

  num h = double.infinity;
  print(h.isInfinite);

  bool isActive = true;
  List<int> numbers1 = [
    1,
    2,
    3,
    4,
    if (isActive)
      for (var item in list1) item,
  ];

  List<int> list4 = [1, 0, 2];
  list4.sort();
  list4 = list1.reversed.toList();
  list4.addAll([5, 3, 4]);
  list4.sort();
  list4 = list4.map((e) => e * 2).toList();
  print(list4);

  List<int> onGoList2 =
      ([1, 3, 2]
        ..sort()
        ..reversed
        ..toList()
        ..addAll([4, 6])
        ..map((e) => e * 1).toList());
  print(onGoList2);
}

class A {
  num a = 5;
  static num b = 5;
}
