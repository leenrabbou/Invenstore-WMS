// ignore_for_file: camel_case_types, must_be_immutable, file_names

import 'package:buymore/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    required this.text,
    required this.hint,
    required this.controller,
    required this.width,
    required this.height,
    required this.left,
    required this.right,
    required this.top,
    required this.bottom,
    required this.maxLines,
    required this.errorMsg,
    required this.fillColor,
    required this.prefix,
    required this.suffix,
    required this.obscure,
    required this.inputFormatter,
    @required this.maxLength,
  });
  TextEditingController controller;
  String hint, errorMsg;
  double height, width, left, right, top, bottom;
  bool maxLines, obscure, suffix;
  Color? fillColor;
  Icon? prefix;
  String? text;
  int? maxLength;
  List<TextInputFormatter>? inputFormatter;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.left,
        right: widget.right,
        top: widget.top,
        bottom: widget.bottom,
      ),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.text != null
                ? Text(
                    widget.text!,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 6,
            ),
            TextFormField(
              maxLines: widget.maxLines ? 3 : 1,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return widget.errorMsg;
                }
                return null;
              },
              maxLength: widget.maxLength,
              inputFormatters: widget.inputFormatter,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
              controller: widget.controller,
              obscureText: widget.obscure,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                isDense: isArabic() ? true : false,
                fillColor: widget.fillColor,
                suffixIcon: widget.suffix
                    ? IconButton(
                        icon: Icon(
                          widget.obscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            widget.obscure = !widget.obscure;
                          });
                        },
                      )
                    : null,
                prefixIcon: widget.prefix,
                filled: true,
                hintText: widget.hint,
                hintStyle: TextStyle(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  fontSize: 15,
                ),
                errorStyle: const TextStyle(color: Colors.red),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
