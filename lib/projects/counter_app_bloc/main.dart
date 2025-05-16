import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const CounterApp());

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App with BLoC',
      home: BlocProvider(
        create: (_) => CounterBloc(),
        child: const CounterScreen(),
      ),
    );
  }
}

// Counter Events
abstract class CounterEvent {}

class Increment extends CounterEvent {}
class Decrement extends CounterEvent {}

// Counter State
class CounterState {
  final int count;
  CounterState({this.count = 0});
}

// Counter BLoC
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState()) {
    on<Increment>((event, emit) {
      emit(CounterState(count: state.count + 1));
    });

    on<Decrement>((event, emit) {
      emit(CounterState(count: state.count - 1));
    });
  }
}

// Counter Screen
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Counter App')),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Count: ${state.count}',
                  style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 40),
                      onPressed: () => counterBloc.add(Decrement()),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: const Icon(Icons.add, size: 40),
                      onPressed: () => counterBloc.add(Increment()),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
