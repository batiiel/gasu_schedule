import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late final StreamSubscription _connectivityStream;

  InternetCubit({required this.connectivity}) : super(InternetState()) {
    _connectivityStream = connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.ethernet) ||
          result.contains(ConnectivityResult.vpn)) {
        emit(InternetState(type: InternetTypes.connected));
      } else if (result.contains(ConnectivityResult.none)) {
        emit(InternetState(type: InternetTypes.offline));
      } else {
        emit(InternetState(type: InternetTypes.unknown));
      }
    });
  }

  // InternetCubit({required Connectivity connectivity})
  //     : _connectivity = connectivity,
  //       super(InternetState()) {
  //   _connectivityStream =
  //       _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> res) {
  //     if (res == ConnectivityResult.wifi || res == ConnectivityResult.mobile) {
  //       emit(InternetState(type: InternetTypes.connected));
  //     } else if (res == ConnectivityResult.none) {
  //       emit(InternetState(type: InternetTypes.offline));
  //     } else {
  //       emit(InternetState(type: InternetTypes.unknown));
  //     }
  //   });
  // }

  @override
  Future<void> close() {
    _connectivityStream.cancel();
    return super.close();
  }
}
