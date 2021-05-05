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
  var service = Service();
  var result = await service.post('/api/v1/user/login', parameters);
  return result;
}

/// User information API, [Future<dynamic>].
/// This API requires [token].
/// When we needs user's currently wallet ammount
///
Future<dynamic> queryUserInfo() async {
  var parameters = await addCommonParams();
  var service = Service();
  var result =
      await service.post('/api/v1/user/queryUserInfo', parameters, token: true);
  return result;
}

Future<dynamic> getChannelConfig(int businessType) async {
  var parameters = await addCommonParams();
  parameters['businessType'] = businessType;
  var service = Service();
  var result = await service.post('/api/v1/channel/channelList', parameters,
      token: true);
  return result;
}
