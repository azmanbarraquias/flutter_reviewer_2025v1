import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';

part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<CounterInitializeEvent>(_onInitialize);
    on<CounterIncrementEvent>(_onIncrement);
    on<CounterDecrementEvent>(_onDecrement);
    on<CounterResetEvent>(_onReset);
    on<CounterSelectAllEvent>(_onSelectAll);
    on<CounterSelectExceptEvent>(_onSelectExcept);
  }

  // Handler for initialization
  Future<void> _onInitialize(
    CounterInitializeEvent event,
    Emitter<CounterState> emit,
  ) async {

    emit(state.copyWith(status: CounterStatus.loading));

    await Future.delayed(const Duration(milliseconds: 200));
    emit(
      state.copyWith(
        count: 0,
        selectedAll: false,
        selectedExcept: false,
        status: CounterStatus.loaded,
      ),
    );
  }

  Future<void> _onIncrement(
    CounterIncrementEvent event,
    Emitter<CounterState> emit,
  ) async {
    emit(state.copyWith(status: CounterStatus.loading));
    print(state.props);
    print(state);
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(count: state.count + 1, status: CounterStatus.loaded));
    print(state.props);

  }

  Future<void> _onDecrement(
    CounterDecrementEvent event,
    Emitter<CounterState> emit,
  ) async {
    emit(state.copyWith(status: CounterStatus.loading));
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(count: state.count - 1, status: CounterStatus.loaded));
  }

  Future<void> _onReset(
    CounterResetEvent event,
    Emitter<CounterState> emit,
  ) async {
    emit(state.copyWith(status: CounterStatus.loading));
    await Future.delayed(const Duration(seconds: 3));
    emit(
      state.copyWith(
        count: 0,
        selectedAll: false,
        selectedExcept: false,
        status: CounterStatus.loaded,
      ),
    );
  }

  void _onSelectAll(CounterSelectAllEvent event, Emitter<CounterState> emit) {
    emit(state.copyWith(selectedAll: true, selectedExcept: false));
  }

  void _onSelectExcept(
    CounterSelectExceptEvent event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(selectedAll: false, selectedExcept: true));
  }
}
