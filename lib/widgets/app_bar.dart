import 'package:flutter/material.dart';

PreferredSizeWidget appBar(BuildContext context, String title) {
  return AppBar(
    leading: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.navigate_before,
        color: Theme.of(context).colorScheme.onSurface,
        size: 32,
      ),
    ),
    title: Text(
      title,
      style: Theme.of(context).textTheme.headline4?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
    ),
  );
}

Widget appBarWhite(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Colors.transparent,
    leading: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.navigate_before,
        color: Theme.of(context).colorScheme.surface,
        size: 32,
      ),
    ),
    title: Text(
      title,
      style: Theme.of(context).textTheme.headline4?.copyWith(
            color: Theme.of(context).colorScheme.surface,
          ),
    ),
  );
}

Widget appBarPureBack(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    leading: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.navigate_before,
        color: Theme.of(context).colorScheme.onSurface,
        size: 28,
      ),
    ),
  );
}
