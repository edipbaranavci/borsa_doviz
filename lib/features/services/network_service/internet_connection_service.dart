import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectionService {
  Future<bool> checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.first == ConnectivityResult.none) {
      return false; // İnternet bağlantısı yok
    }
    return true; // İnternet bağlantısı var
  }
}
