class LoginModel {
  String? token;
  double? cashWallet;
  double? loadWallet;

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    cashWallet = json['cashWallet'];
    loadWallet = json['loadWallet'];
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'cashWallet': cashWallet,
        'loadWallet': loadWallet,
      };
}
