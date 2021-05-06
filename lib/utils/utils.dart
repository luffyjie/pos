import 'package:intl/intl.dart';
import 'package:pos/utils/network/profile.dart';

String assetsIcon(String? name) {
  return 'assets/icons/$name.png';
}

String networkIcon(String? name) {
  return '${Profile().fileDomain}$name';
}

String formatAmount(num amount) {
  final oCcy = NumberFormat("#,##0.00", "en_US");
  return oCcy.format(amount.toDouble());
}
