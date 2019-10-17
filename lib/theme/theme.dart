import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData violetLightTheme = _buildVioletLightTheme();

ThemeData _buildVioletLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: Colors.redAccent,
    primaryColor: primaryViolet,
    buttonTheme: _buildVioletButtonLightTheme(base.buttonTheme),
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    textSelectionColor: Colors.blueGrey,
    errorColor: Colors.redAccent,

    textTheme: _buildVioletTextTheme(base.textTheme),
    // TODO: Add the icon themes (103)
    // TODO: Decorate the inputs (103)
  );
}

TextTheme _buildVioletTextTheme(TextTheme base) {
  return base.copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w500,
    ),
    title: base.title.copyWith(
        fontSize: 18.0
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
    body2: base.body2.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        color: Colors.black
    ),
  ).apply(
    fontFamily: 'Rubik',
    displayColor: Colors.brown,
    bodyColor: Colors.blueGrey,
  );
}

ButtonThemeData _buildVioletButtonLightTheme(ButtonThemeData base) {
  return base.copyWith(
    buttonColor: Colors.white,
    textTheme: base.textTheme,
  );
}