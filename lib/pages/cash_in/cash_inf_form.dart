import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pos/models/fee_config_model.dart';
import 'package:pos/models/payment_model.dart';
import 'package:pos/pages/payment/payment.dart';
import 'package:pos/services/global.dart';
import 'package:pos/store/cash_in_form_store.dart';
import 'package:pos/store/user_store.dart';
import 'package:pos/utils/utils.dart';
import 'package:pos/widgets/app_bar.dart';
import 'package:pos/widgets/button.dart';
import 'package:pos/widgets/loading/loading_dialog.dart';
import 'package:pos/widgets/notice/banner_notice.dart';
import 'package:pos/widgets/notice/notice.dart';
import 'package:provider/provider.dart';

class CashInForm extends StatefulWidget {
  final Map<String, dynamic>? data;

  const CashInForm({Key? key, this.data}) : super(key: key);

  @override
  _CashInFormState createState() => _CashInFormState();
}

class _CashInFormState extends State<CashInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CashInFormStore _store = CashInFormStore();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _amountFocus = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final _PhonepNumberTextInputFormatter _phoneNumberFormatter =
      _PhonepNumberTextInputFormatter();
  final _AmountNumberTextInputFormatter _amountNumberFormatter =
      _AmountNumberTextInputFormatter();

  double? _amount;
  double? _fee;
  double? _feeRate;
  int? _businessType;
  int? _type;
  String? _icon;
  String? _name;
  bool _enable = false;

  @override
  void initState() {
    super.initState();
    _businessType = widget.data?['businessType'];
    _type = widget.data?['type'];
    _icon = widget.data?['icon'];
    _name = widget.data?['name'];
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      UserStore.of(context).queryWallet();
    });
    _phoneFocus.addListener(() {
      if (_phoneFocus.hasFocus) {
        _store.showPhoneFocus();
      } else {
        _store.hiddenPhoneFocus();
      }
    });
    _amountFocus.addListener(() {
      if (_amountFocus.hasFocus) {
        _store.showAmountFoucs();
      } else {
        _store.hiddenAmountFoucs();
      }
    });

    getConfig();
  }

  void getConfig() async {
    var result = await getInitConfig();

    if (result.data != null) {
      List<dynamic> feeConfigList = result.data['feeList'];
      List<FeeConfigModel> list = feeConfigList
          .map<FeeConfigModel>((item) => FeeConfigModel.fromJson(item))
          .toList();
      int index = list.indexWhere((item) => item.businessType == 1);
      if (index > -1) {
        setState(() {
          _feeRate = list[index].serviceFee ?? 0.0;
        });
      }
    } else {
      showErrorBar(context, result['message']);
    }
  }

  bool _validatePhoneNumber(String value) {
    var phoneExp = RegExp(r'^[0]{1}[9]{1}[0-9]{9}$');
    if (!phoneExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  bool _validateAmountNumber(String value) {
    var data = num.tryParse(value) ?? 0;
    if (data < 100 || data > 40000) {
      return false;
    }
    return true;
  }

  _validateEnbale() {
    if (mounted) {
      bool enable;
      var cashWallet = UserStore.of(context).cashWallet ?? 0;
      if (cashWallet > (_amount ?? 0)) {
        _store.hiddenWalletInsufficientNotice();
        enable = (_phoneController.text.isNotEmpty &&
            _amountController.text.isNotEmpty);
      } else {
        enable = false;
        _store.showWalletInsufficientNotice();
      }
      setState(() {
        _enable = enable;
      });
    }
  }

  _submitAction() {
    final form = _formKey.currentState;
    var phoneText = _phoneController.text;
    var amountText = _amountController.text;
    var _phoneValidate = _validatePhoneNumber(phoneText);
    var _amountValidate = _validateAmountNumber(amountText);
    if (!_phoneValidate) {
      showWarningBar(
        context,
        'Please enter a 11-digit mobile no. (e.g. 09XXXXXXXXX).',
      );
    } else if (!_amountValidate) {
      showWarningBar(
          context, 'Transaction amount must be an integer from 100 to 40000.');
    } else {
      var cashWallet = UserStore.of(context).cashWallet ?? 0;
      if ((_amount ?? 0) <= cashWallet) {
        form?.save();
        _phoneFocus.unfocus();
        _amountFocus.unfocus();
        _comfirm();
      }
    }
  }

  _comfirm() async {
    var data = {
      'goodAmount': _amount,
      'goodsName': _phoneController.text,
      'goodId': _type,
      'businessType': _businessType,
    };
    showLoadingDialog(context);
    var result = await payment(data);
    dismissLoadingDialog(context);
    if (result.data != null) {
      var model = PaymentModel.fromJson(result.data);
      var currency = model.paymentList?.first.currency ?? '₱';
      var methodId = model.paymentList?.first.methodId;
      var tmpId = model.tmpId;
      showPay(
        context,
        methodId,
        tmpId,
        currency,
        _amount,
        model.paymentList?.first.serviceFee,
      );
    } else {
      showErrorBar(context, result.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: colorScheme.primaryVariant,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      SizedBox(height: 55),
                      Opacity(
                        opacity: 0.1,
                        child: Image.asset(assetsIcon('banner_logo'),
                            fit: BoxFit.contain),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 64,
                      child: appBarWhite(context, 'Cash Money'),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Cash Wallet',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Consumer<UserStore>(
                          builder: (context, user, child) {
                            return Text(
                              "₱ ${formatAmount(user.cashWallet ?? 0)}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: colorScheme.secondaryVariant,
              child: Stack(
                children: [
                  Container(
                    color: colorScheme.primaryVariant,
                    height: 50,
                  ),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        decoration: BoxDecoration(
                          color: colorScheme.background,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 45,
                                  child: Image.network(
                                    networkIcon(_icon),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(_name ?? '', style: textTheme.bodyText2),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 15,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 7.5,
                                    child: Row(
                                      children: List.generate(
                                        350 ~/ 10,
                                        (index) => Expanded(
                                          child: Container(
                                            color: index % 2 == 0
                                                ? Colors.transparent
                                                : colorScheme.onSecondary
                                                    .withAlpha(50),
                                            height: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: -7.5,
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        color: colorScheme.secondaryVariant,
                                        borderRadius:
                                            BorderRadius.circular(7.5),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: -7.5,
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        color: colorScheme.secondaryVariant,
                                        borderRadius:
                                            BorderRadius.circular(7.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 12, right: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Mobile No.',
                                          style: TextStyle(
                                            color: colorScheme.onBackground,
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextFormField(
                                          autofocus: false,
                                          controller: _phoneController,
                                          focusNode: _phoneFocus,
                                          style: textTheme.subtitle1
                                              ?.copyWith(fontSize: 18),
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            filled: false,
                                            hintText: 'e.g. 09XXXXXXXXX',
                                            hintStyle:
                                                textTheme.bodyText2?.copyWith(
                                              color: colorScheme.onSecondary,
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color:
                                                      colorScheme.onSecondary),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: colorScheme.primary),
                                            ),
                                          ),
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            _phoneNumberFormatter,
                                          ],
                                          onChanged: (value) {
                                            _validateEnbale();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 12, right: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Transaction Amount',
                                          style: TextStyle(
                                            color: colorScheme.onSurface,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextFormField(
                                          autofocus: false,
                                          controller: _amountController,
                                          style: textTheme.subtitle1
                                              ?.copyWith(fontSize: 18),
                                          focusNode: _amountFocus,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            filled: false,
                                            prefixIcon: Text('₱ '),
                                            prefixIconConstraints:
                                                BoxConstraints(
                                                    minWidth: 0, minHeight: 0),
                                            prefixStyle: textTheme.bodyText1,
                                            hintText: 'Minimum 100',
                                            hintStyle:
                                                textTheme.bodyText2?.copyWith(
                                              color: colorScheme.onSecondary,
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color:
                                                      colorScheme.onSecondary),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: colorScheme.primary),
                                            ),
                                          ),
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            _amountNumberFormatter
                                          ],
                                          onSaved: (value) {
                                            var valueStr = value ?? '0';
                                            var amount =
                                                num.tryParse(valueStr) ?? 0;
                                            _amount = amount.toDouble();
                                          },
                                          onChanged: (value) {
                                            var amount =
                                                num.tryParse(value) ?? 0;
                                            _amount = amount.toDouble();
                                            _validateEnbale();
                                            setState(() {
                                              var amountValue =
                                                  amount.toDouble();
                                              var feeRate = _feeRate ?? 0;
                                              _fee = amountValue > 0
                                                  ? (amountValue + feeRate)
                                                  : amountValue;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                padding: EdgeInsets.only(top: 10, left: 12),
                                child: Text(
                                  'Convenience Fee: ₱ ${formatAmount(_feeRate ?? 0)}',
                                  style: textTheme.bodyText1?.copyWith(
                                      color: colorScheme.primary, fontSize: 15),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Observer(builder: (_) {
                    return _store.walletInsufficient
                        ? BannerNotice(
                            text:
                                'Your cash wallet is insufficient, the available transaction amount is ₱XXX.',
                          )
                        : Opacity(opacity: 0);
                  })
                ],
              ),
            ),
          ),
          Container(
            height: 94,
            child: Column(
              children: [
                Divider(height: 1),
                SizedBox(height: 10),
                Text(
                  'Please verify all the above details before proceeding.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyText1?.copyWith(
                    fontSize: 13,
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Amount',
                              style: TextStyle(
                                color: Color(0xff666666),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '₱ ${formatAmount(_fee ?? 0)}',
                              style: TextStyle(
                                color: Color(0xff1196D2),
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        right: 15,
                      ),
                      height: 45,
                      width: 137,
                      child: SizedBoxFlatButton(
                        borderRadius: 22.5,
                        enable: _enable,
                        name: 'CONFIRM',
                        onPressed: () {
                          _submitAction();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _phoneFocus.dispose();
    _amountFocus.dispose();
    super.dispose();
  }
}

class _PhonepNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = newValue.text;
    if (value.length > 11) {
      var selectionIndex = newValue.selection.end;
      value = value.substring(0, value.length - 1);
      selectionIndex--;
      return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: selectionIndex),
      );
    }
    final newTextLength = newValue.text.length;
    final newText = StringBuffer();
    var selectionIndex = newValue.selection.end;
    var usedSubstringIndex = 0;
    if (newTextLength >= 1) {
      if (!newValue.text.startsWith('0')) {
        newText.write('0');
        if (newValue.selection.end >= 1) selectionIndex++;
      }
    }
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class _AmountNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = newValue.text;
    var selectionIndex = newValue.selection.end;
    if (value.startsWith('0')) {
      value = '';
      if (newValue.selection.end >= 1) selectionIndex--;
    }
    var amountNum = num.tryParse(value) ?? 0;
    if (amountNum.toInt() > 4000000) {
      value = value.substring(0, value.length - 1);
      selectionIndex--;
    }
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
