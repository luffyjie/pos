import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

class Core {
  String? appversion;
  int? terminalType;
  String? appName;
  String? packageName;
  String? macAddress;
  int? languageId;
  String? longitude;
  String? latitude;
  String? model;
  String? imei;

  /// 1.wifi 2.line
  int? wifi;
  String? address;
  int? timeZone;
  String? pushClientId;
  String? systVersion;
  String? brand;

  static final Core _instance = Core._internal();

  factory Core() {
    return _instance;
  }

  Core._internal();

  static Future initialize() async {
    var core = Core();
    var deviceInfoPlugin = DeviceInfoPlugin();
    var package = await PackageInfo.fromPlatform();
    core.appversion = package.version;
    core.terminalType = Platform.isIOS ? 1 : 2;
    core.appName = package.appName;
    core.packageName = package.packageName;
    core.macAddress = '';
    core.languageId = 2;
    core.longitude = '';
    core.latitude = '';
    core.wifi = 1;
    core.address = '';
    core.timeZone = 1;
    core.pushClientId = '';
    core.systVersion = Platform.operatingSystemVersion;
    if (Platform.isAndroid) {
      var deviceData = await deviceInfoPlugin.androidInfo;
      core.model = deviceData.model;
      core.imei = deviceData.androidId;
      core.brand = deviceData.product;
      print(_readAndroidBuildData(deviceData));
    } else if (Platform.isIOS) {
      var deviceData = await deviceInfoPlugin.iosInfo;
      core.model = deviceData.model;
      core.imei = '';
      core.brand = deviceData.localizedModel;
      print(_readIosDeviceInfo(deviceData));
    }
  }

  static Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  static Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}
