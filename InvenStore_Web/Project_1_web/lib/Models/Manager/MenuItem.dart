// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MenuItem {
  final IconData icon;
  final String text;
  final Function onPressed;
  MenuItem(
    this.icon,
    this.text,
    this.onPressed,
  );
}
