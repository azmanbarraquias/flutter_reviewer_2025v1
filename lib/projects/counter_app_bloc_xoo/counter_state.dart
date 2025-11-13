part of 'counter_bloc.dart';

enum CounterStatus {
  loading,
  loaded,
  error,
}

class CounterState extends Equatable {
  final CounterStatus status;
  final int count;
  final bool selectedAll;
  final bool selectedExcept;


  const CounterState({
    this.status = CounterStatus.loading,
    this.count = 0,
    this.selectedAll = false,
    this.selectedExcept = false,
  });

  CounterState copyWith({
    CounterStatus? status,
    int? count,
    bool? selectedAll,
    bool? selectedExcept,
  }) =>
      CounterState(
        status: status ?? this.status,
        count: count ?? this.count,
        selectedAll: selectedAll ?? this.selectedAll,
        selectedExcept: selectedExcept ?? this.selectedExcept,
      );

  @override
  List<Object> get props => [status, count, selectedAll, selectedExcept];
}