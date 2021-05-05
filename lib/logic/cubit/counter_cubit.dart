import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_concepts/constants/enums.dart';
import 'package:flutter_bloc_concepts/logic/cubit/internet_cubit.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit({
    @required this.internetCubit,
  }) : super(CounterState(counter: 0)) {
    _monitorInternetCubit();
  }

  StreamSubscription<InternetState> _monitorInternetCubit() {
    return _internetStreamSubscription =
        internetCubit.stream.listen((internetState) {
      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Wifi) {
        increment();
      } else if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Mobile) {
        decrement();
      }
    });
  }

  final InternetCubit internetCubit;
  StreamSubscription _internetStreamSubscription;

  void increment() => emit(CounterState(
        counter: state.counter + 1,
        wasIncremented: true,
      ));

  void decrement() => emit(CounterState(
        counter: state.counter - 1,
        wasIncremented: false,
      ));

  @override
  Future<void> close() {
    _internetStreamSubscription.cancel();
    return super.close();
  }
}
