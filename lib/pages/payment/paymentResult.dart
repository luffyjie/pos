import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pos/pages/payment/payment_indicator.dart';
import 'package:pos/router/app_router.dart';
import 'package:pos/services/global.dart';
import 'package:pos/store/user_store.dart';
import 'package:pos/utils/utils.dart';
import 'package:pos/widgets/button.dart';

class PaymentResult extends StatefulWidget {
  final Map<String, dynamic>? data;

  const PaymentResult({Key? key, this.data}) : super(key: key);

  @override
  _PaymentResultState createState() => _PaymentResultState();
}

class _PaymentResultState extends State<PaymentResult> {
  String? _orderId;
  String? _traceNo;
  String? _mobile;
  String? _icon;
  String? _title;
  int? _orderStatus;
  String? _failReason;
  double? _realAmount;
  double? _amount;
  double? _serviceFee;
  String? _orderChannelDesc;
  String? _currency;
  String? _currencySymbol;
  String? _telco;
  int? _orderClassify;
  bool _process = true;
  late Timer _timer;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      UserStore.of(context).queryWallet();
    });
    var data = widget.data;
    _orderStatus = data?['orderStatus'];
    _realAmount = data?['realAmount'];
    _currency = data?['currency'];
    _orderId = data?['orderId'];
    _orderClassify = data?['orderClassify'];
    _failReason = data?['failReason'];
    _amount = data?['amountTotal'];
    _serviceFee = data?['serviceFee'];
    _orderChannelDesc = data?['orderChannelDesc'];
    _currencySymbol =
        (_currency ?? 'php').toLowerCase() == 'php' ? '₱' : _currency;
    var end = (_orderStatus == 1 || _orderStatus == 2);
    _process = end ? false : true;
    _configIcons();
    if (!end) {
      var period = Duration(seconds: 1);
      Timer.periodic(period, (timer) {
        _timer = timer;
        _count++;
        if (_count > 10) {
          _process = false;
          _result();
        }
      });
      _queryOrderStatus();
    }
    if (_orderStatus == 1) {
      _loadOrderDetail();
    }
  }

  _queryOrderStatus() async {
    var result = await queryOrderStatus(_orderId ?? '');
    if (result['data'] != null) {
      var data = result['data'];
      _orderStatus = data['orderStatus'] ?? 0;
      _failReason = data['failReason'];
      if (_orderStatus == 1 || _orderStatus == 2) {
        _result();
      } else {
        if (_count < 10) {
          _queryOrderStatus();
        }
      }
    }
  }

  _configIcons() {
    switch (_orderStatus) {
      case 1:
        _icon = 'result_success';
        _title = 'Transaction Completed';
        break;
      case 2:
        _icon = 'result_failure';
        _title = 'Transaction Failed';
        break;
      default:
        _icon = 'result_progress';
        _title = 'No Response from Server';
        _failReason =
            'Please check back later in the transaction history for actual result.';
    }
  }

  _result() {
    _timer.cancel();
    if (mounted) {
      setState(() {
        _configIcons();
        _process = false;
      });
    }
    if (_orderStatus == 1) {
      _loadOrderDetail();
    }
  }

  _detail() {
    // var map = Map<String, dynamic>();
    // map['orderId'] = _orderId;
    // map['orderStatus'] = _orderStatus;
    // map['realAmount'] = _realAmount;
    // map['currency'] = _currency;
    // map['statusDesc'] = _failReason;
    // map['orderClassify'] = _orderClassify;
    // var json = jsonEncode(map);
    // var query = Uri.encodeComponent(json);
    // AppRouter.push(context, '${Routes.transDetail}?data=$query');
  }

  _loadOrderDetail() async {
    var result = await orderDetail(_orderId ?? '');
    if (result['data'] != null) {
      var data = result['data'];
      _mobile = data['userPhone'];
      _traceNo = data['traceNo'];
      _telco = data['telco'];
      _receipt();
    }
  }

  _receipt() {}

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (!_process) {
            AppRouter.backHome(context);
          }
          return Future.value(false);
        },
        child: Stack(
          children: [
            Column(
              children: [
                Spacer(),
                Container(
                  width: 58,
                  height: 58,
                  child: Image.asset(
                    assetsIcon(_icon),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 36, right: 36),
                  child: Text(
                    _title ?? '',
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.only(left: 36, right: 36),
                  child: Text(
                    _failReason ?? '',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary),
                    textAlign: TextAlign.center,
                    maxLines: 5,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  '$_orderClassify',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                SizedBox(height: 10),
                Text('$_currencySymbol ${formatAmount(_realAmount ?? 0)}',
                    style: Theme.of(context).textTheme.headline2),
                Spacer(),
                _toolBar(_orderStatus),
                SizedBox(height: 10),
                Container(
                  height: 40,
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: SizedBoxFlatButton(
                    borderRadius: 20,
                    name: 'BACK TO HOME',
                    onPressed: () {
                      AppRouter.backHome(context);
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
            _indicator(_process),
          ],
        ),
      ),
    );
  }

  _indicator(bool data) {
    if (data) {
      return Container(
        color: Theme.of(context).colorScheme.background,
        child: PaymentIndicator(),
      );
    } else {
      return Opacity(
        opacity: 0,
      );
    }
  }

  _toolBar(int? data) {
    if (data == 1) {
      return Container(
        height: 32,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: _receipt,
              child: Text('PRINT AGAIN'),
            ),
            VerticalDivider(
              width: 2,
              color: Colors.grey,
            ),
            TextButton(
              onPressed: _detail,
              child: Text('VIEW DETAILS'),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: TextButton(
          onPressed: _detail,
          child: Text('VIEW DETAILS'),
        ),
      );
    }
  }
}
