// ignore_for_file: file_names
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Lato',
  scaffoldBackgroundColor: const Color(0xfffbfbfb),
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    background: const Color(0xfffbfbfb),
    onBackground: Colors.black87,
    primary: const Color.fromARGB(255, 104, 168, 221),
    onPrimary: const Color(0xff242527),
    secondary: Colors.black87,
    onSecondary: Colors.black54,
    error: Colors.grey.shade400,
    onError: Colors.grey.shade400,
    surface: const Color(0xfffbfbfb).withOpacity(0.9),
    onSurface: const Color(0xffeef3ef),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Lato',
  scaffoldBackgroundColor: const Color(0xff242527),
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    background: const Color(0xff242527),
    onBackground: Colors.white,
    primary: const Color.fromARGB(255, 104, 168, 221),
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: const Color.fromARGB(224, 226, 220, 220),
    error: Colors.grey.shade800,
    onError: Colors.grey.shade800,
    surface: const Color(0xff242527).withOpacity(0.5),
    onSurface: const Color(0xff242527).withOpacity(0.5),
  ),
);
