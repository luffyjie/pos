import 'package:shared_preferences/shared_preferences.dart';

import 'http_manager.dart';

class Service {
  static final Service _instance = Service._internal();

  factory Service() {
    return _instance;
  }

  Service._internal();

  Future<dynamic> post(String path, Map<String, dynamic> parameters) async {
    var header = {'pos': 'app'};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['token'] = prefs.getString('token') ?? '';
    dynamic result = await HttpManager.getInstance()
        .post(path, parameters: parameters, headers: header);
    return result;
  }
}
