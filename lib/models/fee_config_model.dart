/// businessType 1.cashin 2.buy load 3.send 4.pay bills

class FeeConfigModel {
  int? methodId;
  String? methodName;
  String? methodLogo;
  double? serviceFee;
  String? currency;
  int? businessType;

  FeeConfigModel.fromJson(Map<String, dynamic> json) {
    methodId = json['methodId'];
    methodName = json['methodName'];
    methodLogo = json['methodLogo'];
    serviceFee = json['serviceFee'];
    currency = json['currency'];
    businessType = json['businessType'];
  }
}
