import 'package:pos/utils/network/profile.dart';

String assetsIcon(String? name) {
  return 'assets/icons/$name.png';
}

String networkIcon(String? name) {
  return '${Profile().fileDomain}$name';
}
