import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_bloc.dart'; // Assuming your bloc files are imported

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterBloc()..add(const CounterInitializeEvent()),
        child: const CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  String _statusText(CounterStatus status) {
    switch (status) {
      case CounterStatus.loading:
        return 'Loading...';
      case CounterStatus.loaded:
        return 'Loaded!';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Bloc Example')),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            // Show loading indicator if needed
            if (state.status == CounterStatus.loading) {
              return const CircularProgressIndicator();
            }
            // Show counter and controls
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _statusText(state.status),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Count: ${state.count}',
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text('Increment'),
                      onPressed: () => context.read<CounterBloc>().add(const CounterIncrementEvent()),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      child: const Text('Decrement'),
                      onPressed: () => context.read<CounterBloc>().add(const CounterDecrementEvent()),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      child: const Text('Reset'),
                      onPressed: () => context.read<CounterBloc>().add(const CounterResetEvent()),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.selectedAll ? Colors.blue : Colors.grey,
                      ),
                      child: const Text('Select All'),
                      onPressed: () => context.read<CounterBloc>().add(const CounterSelectAllEvent()),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.selectedExcept ? Colors.orange : Colors.grey,
                      ),
                      child: const Text('Select Except'),
                      onPressed: () => context.read<CounterBloc>().add(const CounterSelectExceptEvent()),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Selected All: ${state.selectedAll}\nSelected Except: ${state.selectedExcept}',
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}