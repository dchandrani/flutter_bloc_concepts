part of 'counter_cubit.dart';

class CounterState {
  int counter;
  bool wasIncremented;

  CounterState({
    @required this.counter,
    this.wasIncremented,
  });

  Map<String, dynamic> toMap() {
    return {
      'counter': counter,
      'wasIncremented': wasIncremented,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      counter: map['counter'],
      wasIncremented: map['wasIncremented'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source));
}
