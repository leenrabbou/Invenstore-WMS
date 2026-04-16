// ignore_for_file: file_names

import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    background: Colors.white,
    onBackground: Colors.grey.shade400,
    primary: const Color.fromARGB(255, 104, 168, 221),
    onPrimary: const Color(0xff242527),
    secondary: Colors.black87,
    onSecondary: Colors.black54,
    error: Colors.grey.shade400,
    onError: Colors.grey.shade400,
    surface: const Color(0xfff1f2f6),
    // onSurface: const Color(0xfff1f2f6),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    background: const Color(0xff242527),
    onBackground: Colors.grey.shade800,
    primary: const Color.fromARGB(255, 104, 168, 221),
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: const Color.fromARGB(225, 189, 182, 182),
    error: Colors.grey.shade800,
    onError: Colors.grey.shade800,
    surface: const Color(0xff333436),
    // onSurface: const Color(0xff333436),
  ),
);
