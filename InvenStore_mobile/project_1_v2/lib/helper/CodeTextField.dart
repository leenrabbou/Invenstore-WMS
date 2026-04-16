// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeTextField extends StatelessWidget {
  const CodeTextField(
      {super.key, required this.textController, required this.isLast});
  final TextEditingController textController;
  final bool isLast;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 54,
      child: TextFormField(
        controller: textController,
        onChanged: (value) {
          isLast
              ? null
              : value.length == 1
                  ? FocusScope.of(context).nextFocus()
                  : null;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          filled: true,
          hintText: '0',
          hintStyle:
              TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          errorStyle: const TextStyle(color: Colors.red),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: Color(0xff69a8dd),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: Color.fromARGB(45, 215, 227, 236),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 104, 168, 221),
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
