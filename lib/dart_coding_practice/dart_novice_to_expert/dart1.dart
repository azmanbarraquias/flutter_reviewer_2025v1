// Content over view
// What is Dart?
// Type safety - Compiler checks for errors at compile time
// Soundness - Compiler checks for errors at compile time and runtime
// Type inference
// Null safety
// Dart Compilers

// What is dart?
// Dart is a programming language developed by Google.

// Type of compiler
// JIT - Just in time compilation
// AOT - Ahead of time compilation
// dartdevc - Dart compiler
// dart2js - Dart to JavaScript compiler

// Development phase (use JIT[hot reload])
// - Easy to test the code
// - Easy to debug the code
// - Live metric support
// - Fast coding cycle
// - Incremental recompilation

// Production phase (use AOT[build time])
// - App should start fast
// - App should run fast
// - App doesn't need extra debugging features
// - App doesn't need hot-reload anymore
// - App should be complied into machine code

void main() {
  String stringX = 'Hello world';
  int integerX = 1;
  double doubleX = 1.0;
  bool boolX = true;
  var varX = 'Hello world';
  dynamic dynamicX = 'Hello world';
  dynamicX = 1;
  dynamicX = 1.0;
  dynamicX = true;
  print(stringX.split(' '));
  print(integerX);
  print(doubleX);
  print(boolX);
  print(varX);
  print(dynamicX);

  print('object');
}