import 'package:flutter/material.dart';

class NumberKeyboard extends StatefulWidget {
  final Function(String text) onKeyboardTap;
  final Function() rightButtonFn;

  const NumberKeyboard(
      {Key? key, required this.onKeyboardTap, required this.rightButtonFn})
      : super(key: key);

  @override
  _NumberKeyboard createState() => _NumberKeyboard();
}

class _NumberKeyboard extends State<NumberKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          bottom: 0,
          left: 0,
          child: Row(
            children: [
              Spacer(),
              VerticalDivider(color: Colors.grey[350], width: 1),
              Spacer(),
              VerticalDivider(color: Colors.grey[350], width: 1),
              Spacer(),
            ],
          ),
        ),
        Column(
          children: [
            Divider(color: Colors.grey[350], height: 1),
            Row(
              children: [
                _button('1'),
                VerticalDivider(color: Colors.grey[350], width: 1),
                _button('2'),
                VerticalDivider(color: Colors.grey[350], width: 1),
                _button('3'),
              ],
            ),
            Divider(color: Colors.grey[350], height: 1),
            Row(
              children: [
                _button('4'),
                _button('5'),
                _button('6'),
              ],
            ),
            Divider(color: Colors.grey[350], height: 1),
            Row(
              children: [
                _button('7'),
                _button('8'),
                _button('9'),
              ],
            ),
            Divider(color: Colors.grey[350], height: 1),
            Row(
              children: [
                Spacer(),
                _button('0'),
                _rightButton(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _button(String value) {
    return Expanded(
      child: InkWell(
        onTap: () {
          widget.onKeyboardTap(value);
        },
        child: Container(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Center(
            child: Text(
              value,
              style: TextStyle(color: Colors.black, fontSize: 26),
            ),
          ),
        ),
      ),
    );
  }

  Widget _rightButton() {
    return Expanded(
      child: InkWell(
        onTap: () {
          widget.rightButtonFn();
        },
        child: Center(
          child: Icon(Icons.backspace),
        ),
      ),
    );
  }
}
