// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.height,
    required this.width,
    required this.left,
    required this.right,
    required this.top,
    required this.bottom,
    required this.textSize,
    required this.color,
    required this.elevation,
    required this.textcolor,
  });
  void Function()? onPressed;
  Widget? child;
  double height, width, left, right, top, bottom, textSize, elevation;
  Color color, textcolor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: elevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: color,
              fixedSize: const Size(double.infinity, double.infinity),
            ),
            child: child),
      ),
    );
  }
}
