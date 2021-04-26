import 'package:flutter/material.dart';
import 'package:pos/widgets/indicator/hud_loading.dart';

showLoadingCircularProgressDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Text("Processing please wait..."),
              )
            ],
          ),
        ),
      );
    },
  );
}

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          content: Center(
            child: HudLoading(),
          ),
        ),
      );
    },
  );
}

dismissLoadingDialog(BuildContext context) {
  Navigator.of(context).pop();
}
