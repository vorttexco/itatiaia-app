// import 'package:connectivity_plus/connectivity_plus.dart';

class AppManager {
  // static Future<bool> isConnected() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   return (!connectivityResult.contains(ConnectivityResult.none));
  // }

  static Future<bool> isLogged() async {
    return true;
  }

  static get hostApi => 'https://api.itatiaia.com.br';
}
