import 'package:flutter/material.dart';
import 'package:pos/router/app_router.dart';
import 'package:pos/store/user_store.dart';

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
    await UserStore.of(context).loadStore();
    if (UserStore.of(context).token != null) {
      UserStore.of(context).queryWallet();
      AppRouter.pushAndReplace(context, Routes.home);
    } else {
      AppRouter.pushAndReplace(context, Routes.login);
    }
  }
}
