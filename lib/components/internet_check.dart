import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

bool _connected = false;
bool get connected => _connected;
late final Stream<ConnectivityResult> connectionStream;
// final connectionStreamProvider = StreamProvider((_) => connectionStream);

void initConnectionListener() => connectionStream =
    Connectivity().onConnectivityChanged..listen(onConnectionChanged);

void onConnectionChanged(ConnectivityResult c) =>
    _connected = c != ConnectivityResult.none;
Future<bool> hasInternet() async {
  if (!connected) {
    EasyLoading.showError('No Internet Connection');
    return false;
  }
  try {
    final result = await InternetAddress.lookup('example.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}
