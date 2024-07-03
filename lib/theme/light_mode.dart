import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightMode = ThemeData(
  scaffoldBackgroundColor: Color.lerp(Colors.pink, Colors.white, 0.9),
  appBarTheme: AppBarTheme(
    backgroundColor: Color.lerp(
        Color.lerp(Colors.blue, Colors.white, 0.9), Colors.purple, 0.5),
    titleSpacing: 0,
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black.withOpacity(0.4),
        statusBarBrightness: Brightness.light),
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade300,
  ),
);
