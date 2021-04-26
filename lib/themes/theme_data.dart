import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  platform: TargetPlatform.android,
  colorScheme: _colorScheme,
  textTheme: _textTheme.apply(
      bodyColor: _colorScheme.onSurface, displayColor: _colorScheme.onSurface),
  primaryColor: _colorScheme.primary,
  appBarTheme: AppBarTheme(
    textTheme: _textTheme.apply(bodyColor: _colorScheme.onSurface),
    color: _colorScheme.secondary,
    iconTheme: IconThemeData(),
    elevation: 0,
    brightness: _colorScheme.brightness,
    centerTitle: true,
  ),
  iconTheme: IconThemeData(color: _colorScheme.primary),
  canvasColor: _colorScheme.background,
  scaffoldBackgroundColor: _colorScheme.background,
  highlightColor: Colors.transparent,
  accentColor: _colorScheme.primary,
  focusColor: _colorScheme.onSurface,
  backgroundColor: _colorScheme.background,
  toggleableActiveColor: _colorScheme.primary,
  indicatorColor: _colorScheme.onPrimary,
  bottomAppBarTheme: BottomAppBarTheme(
    color: _colorScheme.primary,
  ),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    colorScheme: _colorScheme,
  ),
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
  ),
);

ColorScheme _colorScheme = ColorScheme(
  primary: Color(0xFF00A0E9),
  primaryVariant: Color(0xFF0079EA),
  secondary: Color(0xFFEDEDED),
  secondaryVariant: Color(0xFFF6F6F6),
  background: Color(0xFFFFFFFF),
  surface: Color(0xFFFFFFFF),
  error: Color(0xFFFF001D),
  onPrimary: Color(0xFFFFFFFF),
  onBackground: Color(0xFF666666),
  onSecondary: Color(0xFF999999),
  onSurface: Color(0xFF232323),
  onError: Color(0xFFFFFFFF),
  brightness: Brightness.light,
);

const _regular = FontWeight.w400;
const _medium = FontWeight.w500;
const _semiBold = FontWeight.w600;
const _bold = FontWeight.w700;

TextTheme _textTheme = TextTheme(
  subtitle1: TextStyle(fontWeight: _medium, fontSize: 14.0),
  subtitle2: TextStyle(fontWeight: _medium, fontSize: 16.0),
  headline1: TextStyle(fontWeight: _bold, fontSize: 34.0),
  headline2: TextStyle(fontWeight: _bold, fontSize: 30.0),
  headline3: TextStyle(fontWeight: _bold, fontSize: 24.0),
  headline4: TextStyle(fontWeight: _bold, fontSize: 20.0),
  headline5: TextStyle(fontWeight: _medium, fontSize: 16.0),
  headline6: TextStyle(fontWeight: _medium, fontSize: 14.0),
  bodyText1: TextStyle(fontWeight: _regular, fontSize: 14.0),
  bodyText2: TextStyle(fontWeight: _regular, fontSize: 16.0),
  button: TextStyle(fontWeight: _semiBold, fontSize: 14.0),
  caption: TextStyle(fontWeight: _semiBold, fontSize: 16.0),
  overline: TextStyle(fontWeight: _medium, fontSize: 12.0),
);
