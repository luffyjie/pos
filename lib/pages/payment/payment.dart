import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pos/router/app_router.dart';
import 'package:pos/services/global.dart';
import 'package:pos/utils/utils.dart';
import 'package:pos/widgets/loading/loading_dialog.dart';
import 'package:pos/widgets/notice/notice.dart';

import 'number_keyboard.dart';
import 'password.dart';

showPay(
  BuildContext context,
  String? methodId,
  String? tmpId,
  String? currency,
  double? realAmount,
  double? serviceFee,
) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => Payment(
        methodId: methodId,
        tmpId: tmpId,
        currency: currency,
        realAmount: realAmount,
        serviceFee: serviceFee,
      ),
    ),
  );
}

class Payment extends StatefulWidget {
  final String? methodId;
  final String? tmpId;
  final String? currency;
  final double? realAmount;
  final double? serviceFee;

  const Payment({
    Key? key,
    this.methodId,
    this.tmpId,
    this.currency,
    this.realAmount,
    this.serviceFee,
  }) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String _text = '';
  String? _currency;
  double? _realAmount;

  @override
  void initState() {
    super.initState();
    var currency = widget.currency ?? 'php';
    _currency = currency.toLowerCase() == 'php' ? '₱' : _currency;
    _realAmount = widget.realAmount;
  }

  _submitAction(text) async {
    showLoadingDialog(context);
    var data = {
      'payPassword': text,
      'methodId': widget.methodId,
      'tmpId': widget.tmpId,
    };
    var result = await orderPay(data);
    dismissLoadingDialog(context);
    if (result.data != null) {
      if (result.data is Map<String, dynamic>) {
        var json = jsonEncode(result.data);
        var query = Uri.encodeComponent(json);
        AppRouter.pushAndReplace(
            context, '${Routes.paymentResult}?data=$query');
      }
    } else {
      showErrorBar(context, result['message']);
    }
  }

  _onKeyboardTap(String value) {
    setState(() {
      if (_text.length < 6) {
        _text = _text + value;
      }
      if (_text.length == 6) {
        _submitAction(_text);
      }
    });
  }

  _rightButtonFn() {
    setState(() {
      if (_text.isNotEmpty) {
        _text = _text.substring(0, _text.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.black.withAlpha(100),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: 48,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Enter the Payment Password',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pay',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '$_currency',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 20),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '${formatAmount((_realAmount ?? 0) + (widget.serviceFee ?? 0))}',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Password(text: _text),
                  ),
                  SizedBox(height: 25),
                  NumberKeyboard(
                    onKeyboardTap: _onKeyboardTap,
                    rightButtonFn: _rightButtonFn,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
        onWillPop: () async {
          return Future.value(true);
        },
      ),
    );
  }
}
