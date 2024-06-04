import 'package:flutter/material.dart';

import '../colors/colors.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: colorTheme,
  scaffoldBackgroundColor: white,
  primaryColorDark: black.withOpacity(.1),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Poppins',
  appBarTheme:
  const AppBarTheme(color: white, iconTheme: IconThemeData(color: Colors.black)),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: kPrimaryColor).copyWith(background: white),
);