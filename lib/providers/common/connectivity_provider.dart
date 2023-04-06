import 'package:flutter/cupertino.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider extends ChangeNotifier {
  ConnectivityResult? _connectivityResult;

  ConnectivityProvider() {
    getConnectivityStatus();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setConnectivityResult(result);
    });
  }

  ConnectivityResult? get connectivityResult => _connectivityResult;

  Future<ConnectivityResult?> getConnectivityStatus() async {
    _connectivityResult = await (Connectivity().checkConnectivity());
    notifyListeners();
    return _connectivityResult;
  }

  void setConnectivityResult(ConnectivityResult value) {
    _connectivityResult = value;
    notifyListeners();
  }
}
