import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

showErrorBar(BuildContext context, String message) {
  Flushbar(
      margin: EdgeInsets.only(left: 8, right: 8),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      icon: Icon(Icons.error, color: Theme.of(context).colorScheme.onSurface),
      backgroundColor: Colors.red[400] ?? Colors.red,
      titleText: Text('ERROR', style: Theme.of(context).textTheme.headline5),
      messageText: Text(message, style: Theme.of(context).textTheme.bodyText1),
      duration: Duration(seconds: 2),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP)
    ..show(context);
}

showWarningBar(BuildContext context, String message) {
  Flushbar(
      margin: EdgeInsets.only(left: 8, right: 8),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      icon: Icon(Icons.error, color: Theme.of(context).colorScheme.error),
      backgroundColor: Colors.yellow[200] ?? Colors.yellow,
      titleText: Text('WARNING', style: Theme.of(context).textTheme.headline5),
      messageText: Text(message, style: Theme.of(context).textTheme.bodyText1),
      duration: Duration(seconds: 2),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP)
    ..show(context);
}

showSuccessBar(BuildContext context, String message) {
  Flushbar(
      margin: EdgeInsets.only(left: 8, right: 8),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      icon: Icon(
        Icons.check_circle,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      backgroundColor: Colors.green,
      titleText: Text('SUCCESS',
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
      messageText: Text(message,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
      duration: Duration(seconds: 2),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP)
    ..show(context);
}
