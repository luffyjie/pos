class PaymentModel {
  String? tmpId;
  String? methodId;
  List<PaymentListModel>? paymentList;

  PaymentModel.fromJson(Map<String, dynamic> json) {
    methodId = json['methodId'];
    tmpId = json['tmpId'];
    var paymentListData = json['paymentList'];
    if (paymentListData is List) {
      paymentList = paymentListData
          .map<PaymentListModel>((item) => PaymentListModel.fromJson(item))
          .toList();
    }
  }
}

class PaymentListModel {
  String? methodId;
  String? methodName;
  String? methodLogo;
  double? serviceFee;
  String? currency;

  PaymentListModel.fromJson(Map<String, dynamic> json) {
    methodId = json['methodId'];
    methodName = json['methodName'];
    methodLogo = json['methodLogo'];
    serviceFee = json['serviceFee'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() => {
        'methodId': methodId,
        'methodName': methodName,
        'methodLogo': methodLogo,
        'serviceFee': serviceFee,
        'currency': currency,
      };
}

///orderStatus  0.未支付 1.支付成功 2.支付失败
class OrderPayModel {
  String? orderId;
  int? orderStatus;
  String? failReason;
  double? realAmount;
  double? amountTotal;
  double? serviceFee;
  String? currency;
  String? orderChannelDesc;
  int? orderClassify;

  OrderPayModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderStatus = json['orderStatus'];
    failReason = json['failReason'];
    realAmount = json['realAmount'];
    amountTotal = json['amountTotal'];
    serviceFee = json['serviceFee'];
    currency = json['currency'];
    orderClassify = json['orderClassify'];
    orderChannelDesc = json['orderChannelDesc'];
  }

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'orderStatus': orderStatus,
        'failReason': failReason,
        'realAmount': realAmount,
        'amountTotal': amountTotal,
        'serviceFee': serviceFee,
        'currency': currency,
        'orderClassify': orderClassify,
        'orderChannelDesc': orderChannelDesc,
      };
}
