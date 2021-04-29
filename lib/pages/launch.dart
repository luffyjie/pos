import 'package:flutter/material.dart';
import 'package:pos/router/app_router.dart';
import 'package:pos/store/user_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Launch extends StatefulWidget {
  @override
  _LaunchState createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _verifyToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Container(),
      ),
    );
  }

  void _verifyToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    UserStore.of(context).updateToken(token);
    AppRouter.pushAndReplace(context, Routes.login);
    // if (token != null) {
    //   AppRouter.pushAndReplace(context, Routes.home);
    // } else {
    //   AppRouter.pushAndReplace(context, Routes.login);
    // }
  }
}
