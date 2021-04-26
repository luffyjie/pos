import 'package:flutter/material.dart';
import 'package:pos/models/login_model.dart';
import 'package:pos/router/app_router.dart';
import 'package:pos/services/global.dart';
import 'package:pos/store/user_store.dart';
import 'package:pos/utils/utils.dart';
import 'package:pos/widgets/button.dart';
import 'package:pos/widgets/loading/loading_dialog.dart';
import 'package:pos/widgets/notice/notice.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FocusNode _accountFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _enable = false;

  @override
  void initState() {
    super.initState();
  }

  bool _validateAccount(String value) {
    var phoneExp = RegExp(r'^[A-Za-z0-9@_.]+$');
    if (!phoneExp.hasMatch(value)) {
      showWarningBar(context, 'please enter the correct username');
      return false;
    }
    return true;
  }

  bool _validatePassword(String value) {
    var phoneExp = RegExp(r'^[A-Za-z0-9@_.]+$');
    if (!phoneExp.hasMatch(value)) {
      showWarningBar(context, 'please enter the correct password');
      return false;
    }
    return true;
  }

  _validateEnbale() {
    if (mounted) {
      var enable = (_accountController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty);
      setState(() {
        _enable = enable;
      });
    }
  }

  _submitAction(BuildContext context) {
    if (_validateAccount(_accountController.text)) {
      if (_validatePassword(_passwordController.text)) {
        _accountFocus.unfocus();
        _passwordFocus.unfocus();
        _login(_accountController.text, _passwordController.text);
      }
    }
  }

  void _login(String account, String password) async {
    showLoadingDialog(context);
    var result = await login(account, password);
    dismissLoadingDialog(context);
    if (result['data'] != null) {
      var model = LoginModel.fromJson(result['data']);
      UserStore.of(context).updateCashWallet(model.cashWallet);
      UserStore.of(context).updateLoadWallet(model.loadWallet);
      UserStore.of(context).updateToken(model.token);
      AppRouter.pushAndReplace(context, Routes.home);
    } else {
      showErrorBar(context, result.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetsIcon('login_logo'),
              fit: BoxFit.contain,
            ),
            SizedBox(height: 40),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Container(
                margin: EdgeInsets.only(left: 50, right: 50),
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: false,
                      controller: _accountController,
                      focusNode: _accountFocus,
                      keyboardType: TextInputType.text,
                      style: textTheme.subtitle1?.copyWith(fontSize: 17),
                      decoration: InputDecoration(
                        filled: false,
                        labelText: "Username",
                        icon: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Image.asset(
                            assetsIcon('login_account'),
                            fit: BoxFit.contain,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: colorScheme.onSecondary),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.primary),
                        ),
                      ),
                      onChanged: (_) {
                        _validateEnbale();
                      },
                    ),
                    TextFormField(
                      autofocus: false,
                      obscureText: true,
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      style: textTheme.subtitle1?.copyWith(fontSize: 17),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: false,
                        labelText: "Password",
                        icon: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Image.asset(
                            assetsIcon('login_password'),
                            fit: BoxFit.contain,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: colorScheme.onSecondary),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.primary),
                        ),
                      ),
                      onChanged: (_) {
                        _validateEnbale();
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              height: 45,
              padding: EdgeInsets.only(left: 34, right: 34),
              child: SizedBoxFlatButton(
                borderRadius: 22.5,
                enable: _enable,
                name: 'LOGIN',
                onPressed: () {
                  _submitAction(context);
                },
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
