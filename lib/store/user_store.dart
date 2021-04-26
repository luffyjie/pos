import 'package:flutter/material.dart';
import 'package:pos/models/user_model.dart';
import 'package:pos/services/global.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStore extends ChangeNotifier {
  String? token;
  double? cashWallet;
  double? loadWallet;

  updateToken(String? token) {
    token = token;
    save('token', token);
    notifyListeners();
  }

  updateCashWallet(double? cashWallet) {
    cashWallet = cashWallet;
    save('cashWallet', cashWallet);
    notifyListeners();
  }

  updateLoadWallet(double? loadWallet) {
    loadWallet = loadWallet;
    save('loadWallet', loadWallet);
    notifyListeners();
  }

  save(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      prefs.setString(key, value);
    }
    if (value is double) {
      prefs.setDouble(key, value);
    }
  }

  queryWallet() async {
    var result = await queryUserInfo();
    if (result.data != null) {
      var model = UserInfoModel.fromJson(result.data);
      updateCashWallet(model.cashWallet ?? 0);
      updateLoadWallet(model.loadWallet ?? 0);
    }
    return result;
  }

  static remove() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('token');
    await preferences.remove('cashWallet');
    await preferences.remove('loadWallet');
  }

  static UserStore of(BuildContext context) {
    return Provider.of<UserStore>(context, listen: false);
  }
}
