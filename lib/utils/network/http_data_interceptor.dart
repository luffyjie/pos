import 'package:dio/dio.dart';
import 'package:pos/router/app_router.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        int code = response.data["code"];
        if (code == 1044) {
          AppRouter.logout();
        }
      }
    } catch (e) {
      return response.data;
    }
    return response.data;
  }
}
