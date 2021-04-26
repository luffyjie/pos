class UserInfoModel {
  double? cashWallet;
  double? loadWallet;

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    cashWallet = json['cashWallet'];
    loadWallet = json['loadWallet'];
  }

  Map<String, dynamic> toJson() => {
        'cashWallet': cashWallet,
        'loadWallet': loadWallet,
      };
}
