import 'package:dio/dio.dart';
import 'package:pos/utils/network/profile.dart';

class HttpManager {
  late Dio _dio;

  static HttpManager _instance = HttpManager._internal();

  static const CODE_SUCCESS = 200;

  static const CODE_TIME_OUT = -1;

  factory HttpManager() => _instance;

  HttpManager._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Profile.test().apiDomain,
        connectTimeout: 60000,
      ),
    );
  }

  static HttpManager getInstance() {
    return _instance;
  }

  get(api, {parameters}) async {
    Response response;
    try {
      response = await _dio.get(api, queryParameters: parameters);
    } on DioError catch (e) {
      return resultError(e);
    }
    return response.data;
  }

  post(api, {parameters, headers}) async {
    Response response;
    try {
      var options = Options(headers: headers);
      response = await _dio.post(api, data: parameters, options: options);
    } on DioError catch (e) {
      return resultError(e);
    }
    return response.data;
  }

  Map<String, dynamic> resultError(DioError e) {
    var code = e.response?.statusCode ?? 500;
    var message = e.response?.statusMessage ?? ErorMessage.service;
    var headers = e.response?.headers;
    return {
      'code': code,
      'message': message,
      'headers': headers,
    };
  }
}
