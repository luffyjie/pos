import 'package:pos/utils/core.dart';
import 'package:pos/utils/network/service.dart';

Future<Map<String, dynamic>> addCommonParams(
    {Map<String, dynamic>? data}) async {
  var _data = Map<String, dynamic>();
  var core = Core();
  _data['requestTime'] = DateTime.now().millisecondsSinceEpoch;
  _data['appversion'] = core.appversion;
  _data['terminalType'] = core.terminalType;
  _data['appName'] = core.appName;
  _data['packageName'] = core.packageName;
  _data['macAddress'] = core.macAddress;
  _data['languageId'] = core.languageId;
  _data['longitude'] = core.longitude;
  _data['latitude'] = core.latitude;
  _data['model'] = core.model;
  _data['imei'] = core.imei;
  _data['wifi'] = core.wifi;
  _data['address'] = core.address;
  _data['timeZone'] = core.timeZone;
  _data['pushClientId'] = core.pushClientId;
  _data['brand'] = core.brand;
  _data.addAll(data ?? Map());
  return _data;
}

/// User login API, [Future<dynamic>].
/// This API requires [userAccount] [password].
/// We use this at the beginning use first open application
///
Future<dynamic> login(String userAccount, String password) async {
  var parameters = await addCommonParams();
  parameters['userAccount'] = userAccount;
  parameters['password'] = password;
  var result = await Service().post('/api/v1/user/login', parameters);
  return result;
}

/// User information API, [Future<dynamic>].
/// When we needs user's currently wallet ammount
///
Future<dynamic> queryUserInfo() async {
  var parameters = await addCommonParams();
  var result = await Service().post('/api/v1/user/queryUserInfo', parameters);
  return result;
}

/// Payment confirm, [Future<Result>].
/// This API requires [Map<String, dynamic>data].
/// parameter cotains [businessType] [goodId] [goodAmount] [goodsName] [orderTmpId]
///
Future<dynamic> payment(Map<String, dynamic> data) async {
  var parameters = await addCommonParams(data: data);
  var result = await Service().post('/api/v1/payment/panel', parameters);
  return result;
}

/// Order submit, [Future<Result>].
/// This API requires [Map<String, dynamic>data].
/// parameter cotains [tmpId] [methodId] [payPassword]
///
Future<dynamic> orderPay(Map<String, dynamic> data) async {
  var parameters = await addCommonParams(data: data);
  var result = await Service().post('/api/v1/payment/orderPay', parameters);
  return result;
}

Future<dynamic> getChannelConfig(int businessType) async {
  var parameters = await addCommonParams();
  parameters['businessType'] = businessType;
  var result = await Service().post('/api/v1/channel/channelList', parameters);
  return result;
}

Future<dynamic> getInitConfig() async {
  var parameters = await addCommonParams();
  var result = await Service().post('/api/v1/init/initConfig', parameters);
  return result;
}

Future<dynamic> queryOrderStatus(String orderId) async {
  var parameters = await addCommonParams();
  parameters['orderId'] = orderId;
  var result =
      await Service().post('/api/v1/order/queryOrderStatus', parameters);
  return result;
}

Future<dynamic> orderDetail(String orderId) async {
  var parameters = await addCommonParams();
  parameters['orderId'] = orderId;
  var result = await Service().post('/api/v1/order/orderDetails', parameters);
  return result;
}
