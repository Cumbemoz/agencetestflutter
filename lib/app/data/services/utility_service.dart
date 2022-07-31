import 'dart:async';
import 'dart:io';

class UtilityService {
  bool _isOnline = true;

  Future checkConnectivity() async {
    //! For Check, Devide Has Internet Connection
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('O Usuario Tem Acesso a Internet');
        _isOnline = true;
      }
    } on SocketException catch (_) {
      print('O Usuario não tem Acesso a Internet');
      _isOnline = false;
    }
    return _isOnline;
  }
}
