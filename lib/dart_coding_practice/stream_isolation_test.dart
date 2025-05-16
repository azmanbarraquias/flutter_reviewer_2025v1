import 'package:bloc/bloc.dart';

Stream<int> boatStream() async* {
  for (int i = 0; i < 10; i++) {
    print('Send boat no. ' + i.toString());
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

void main() async {
  final cubit = CounterCubit();

  cubit.stream.listen((state) {
    print(state);
  });

  cubit.increment();
  cubit.increment();
  cubit.increment();
}

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);
}
