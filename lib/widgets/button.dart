import 'package:flutter/material.dart';

class SizedBoxFlatButton extends StatelessWidget {
  final String? name;
  final void Function()? onPressed;
  final double? borderRadius;
  final bool? enable;

  const SizedBoxFlatButton(
      {Key? key, this.name, this.onPressed, this.enable, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _borderRadius = borderRadius ?? 0;
    var _color = Theme.of(context).colorScheme.primary;
    var _onPressed = onPressed;
    if (enable == false) {
      _color = Theme.of(context).colorScheme.secondary;
      _onPressed = () {};
    }
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Theme.of(context).colorScheme.secondary,
          onSurface: Theme.of(context).colorScheme.onSurface,
          backgroundColor: _color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
        ),
        onPressed: _onPressed,
        child: Text(
          name ?? '',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: Theme.of(context).colorScheme.background),
        ),
      ),
    );
  }
}
