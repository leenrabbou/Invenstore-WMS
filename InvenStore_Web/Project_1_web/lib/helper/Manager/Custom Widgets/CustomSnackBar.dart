// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomSnackBar {
  void showToast(String text) {
    Fluttertoast();
    Fluttertoast.showToast(
        backgroundColor:
            const Color.fromARGB(255, 104, 168, 221).withOpacity(0.8),
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_LEFT,
        timeInSecForIosWeb: 2,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void snackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: null,
        content: Row(
          children: [
            Flexible(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            )
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
