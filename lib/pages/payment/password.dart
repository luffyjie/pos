import 'dart:math';

import 'package:flutter/material.dart';

class Password extends StatelessWidget {
  final String? text;

  const Password({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var password = text ?? '';
    var data = List.filled(6, '', growable: true);
    var list = password.split('');
    data.replaceRange(0, min(6, password.length), list);
    return Container(
      height: 48,
      padding: EdgeInsets.only(left: 36, right: 36),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[350] ?? Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Row(
          children: [
            Expanded(child: obscureText(data[0])),
            VerticalDivider(color: Colors.grey[350], width: 1),
            Expanded(child: obscureText(data[1])),
            VerticalDivider(color: Colors.grey[350], width: 1),
            Expanded(child: obscureText(data[2])),
            VerticalDivider(color: Colors.grey[350], width: 1),
            Expanded(child: obscureText(data[3])),
            VerticalDivider(color: Colors.grey[350], width: 1),
            Expanded(child: obscureText(data[4])),
            VerticalDivider(color: Colors.grey[350], width: 1),
            Expanded(child: obscureText(data[5])),
          ],
        ),
      ),
    );
  }

  Widget obscureText(String value) {
    if (value == '') {
      return Container();
    }
    return Container(
      child: Center(
        child: ClipOval(
          child: Container(
            width: 10,
            height: 10,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
