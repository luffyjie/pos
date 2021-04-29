import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pos/utils/core.dart';
import 'package:provider/provider.dart';

import 'router/app_router.dart';
import 'store/user_store.dart';
import 'themes/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Core.initialize();
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  final router = FluroRouter.appRouter;

  _AppState() {
    Routes.configureRouters(router);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserStore())],
      child: OKToast(
        child: MaterialApp(
          navigatorKey: AppRouter.navKey,
          title: 'POS',
          debugShowCheckedModeBanner: false,
          theme: themeData,
          initialRoute: Routes.launch,
          onGenerateRoute: router.generator,
        ),
      ),
    );
  }
}
