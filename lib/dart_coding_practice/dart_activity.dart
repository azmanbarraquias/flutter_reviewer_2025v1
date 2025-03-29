
void main()   {
  Map<String, String> person = {
    // Key:    Value
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 'golden rings',
  };

  var nobleGases = {2: 'helium', 10: 'neon', 18: 'argon'};
}

Future<void> printText() async {
   Future.delayed(Duration(seconds: 5)).then((_){

     print('Hello 1');

   });

}

Stream<String> report(String craft, Iterable<String> objects) async* {
  for (final object in objects) {
    await Future.delayed(Duration(seconds: 3));
    print(objects);
    yield '${craft} flies by $object';
  }
}




