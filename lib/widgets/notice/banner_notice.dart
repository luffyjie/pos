import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BannerNotice extends StatelessWidget {
  final String? text;
  final Icon? icon;
  final Color? iconColor;
  final Color? backgroundColor;

  const BannerNotice(
      {Key? key, this.text, this.icon, this.iconColor, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _text = text ?? '';
    var _iconColor = iconColor ?? Theme.of(context).colorScheme.error;
    var _backgroundColor = backgroundColor ?? Colors.yellow[200];
    var _icon = icon ?? Icon(Icons.info_outline, color: _iconColor, size: 22);
    return Container(
      padding: EdgeInsets.only(left: 25, right: 20, top: 5, bottom: 5),
      color: _backgroundColor,
      child: Row(
        children: [
          _icon,
          SizedBox(width: 10),
          Flexible(
            child: Text(
              _text,
              style:
                  Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
