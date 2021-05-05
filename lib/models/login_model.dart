class LoginModel {
  String? token;
  double? cashWallet;
  double? loadWallet;

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    var cashWalletNum = json['cashWallet'];
    var loadWalletNum = json['loadWallet'];
    if (cashWalletNum is num) {
      cashWallet = cashWalletNum.toDouble();
    }
    if (loadWalletNum is num) {
      loadWallet = loadWalletNum.toDouble();
    }
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'cashWallet': cashWallet,
        'loadWallet': loadWallet,
      };
}
