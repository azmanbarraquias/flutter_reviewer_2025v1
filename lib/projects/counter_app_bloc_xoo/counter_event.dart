part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();
}

class CounterInitializeEvent extends CounterEvent {
  const CounterInitializeEvent();

  @override
  List<Object?> get props => [];
}

class CounterIncrementEvent extends CounterEvent {
  const CounterIncrementEvent();

  @override
  List<Object?> get props => [];
}

class CounterDecrementEvent extends CounterEvent {
  const CounterDecrementEvent();

  @override
  List<Object?> get props => [];
}

class CounterResetEvent extends CounterEvent {
  const CounterResetEvent();

  @override
  List<Object?> get props => [];
}

// "Select All" just as an analogy!
class CounterSelectAllEvent extends CounterEvent {
  const CounterSelectAllEvent();

  @override
  List<Object?> get props => [];
}

// "Select All Except" analogue
class CounterSelectExceptEvent extends CounterEvent {
  const CounterSelectExceptEvent();

  @override
  List<Object?> get props => [];
}