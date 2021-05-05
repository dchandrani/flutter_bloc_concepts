import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc_concepts/constants/enums.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit({@required this.connectivity}) : super(CheckingInternet()) {
    _monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult> _monitorInternetConnection() {
    return _connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.Mobile);
      } else if (connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.Wifi);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
  }

  final Connectivity connectivity;
  StreamSubscription _connectivityStreamSubscription;

  void emitInternetConnected(ConnectionType connectionType) => emit(
        InternetConnected(connectionType: connectionType),
      );

  void emitInternetDisconnected() => emit(
        InternetDisconnected(),
      );

  @override
  Future<void> close() {
    _connectivityStreamSubscription.cancel();
    return super.close();
  }
}
