import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos/pages/home/home.dart';
import 'package:pos/pages/launch.dart';
import 'package:pos/pages/login/login.dart';

class AppRouter {
  static final navKey = new GlobalKey<NavigatorState>();

  static void push(BuildContext context, String path) {
    FluroRouter.appRouter.navigateTo(
      context,
      path,
      transition: TransitionType.inFromRight,
    );
  }

  static void back(BuildContext context) {
    Navigator.pop(context);
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static void backHome(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(Routes.home));
  }

  static void pushAndReplace(BuildContext context, String path) {
    FluroRouter.appRouter.navigateTo(context, path,
        replace: true, transition: TransitionType.fadeIn);
  }

  static void exit() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  static void logout() {
    if (navKey.currentContext != null) {
      Navigator.pushNamedAndRemoveUntil(
          navKey.currentContext!, Routes.login, (route) => false);
    }
  }
}

class Routes {
  static String launch = '/';
  static String login = '/login';
  static String home = '/home';
  static String cashIn = '/cashIn';
  static String scan = '/scan';
  static String scanBarcode = '/scanBarcode';
  static String scanQR = '/sendQR';
  static String scanVerify = '/scanVerify';

  static void configureRouters(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc:
        (BuildContext? context, Map<String, List<String>> parameters) {
      debugPrint('Not find page');
      return null;
    });

    /// login
    router.define(launch, handler: lauchRouteHandler);
    router.define(login, handler: loginRouteHandler);

    /// home
    router.define(home, handler: homeRouteHandler);
  }
}

var lauchRouteHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return Launch();
});

var loginRouteHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return Login();
});

var homeRouteHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return Home();
});
