import 'package:flutter/material.dart';

const _primaryColor = Color.fromARGB(0, 0, 217, 255);
const _fontFamily = 'Dosis';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: _fontFamily,
  primaryColor: _primaryColor,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: _fontFamily,
  primaryColor: _primaryColor,
);
