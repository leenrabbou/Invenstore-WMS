// ignore_for_file: file_names, must_be_immutable

import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/main.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField({
    super.key,
    required this.searchController,
    required this.onPressed,
  });
  TextEditingController searchController;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 550,
      child: TextFormField(
        controller: searchController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return S().feild_required;
          }
          return null;
        },
        style: TextStyle(
          color: isArabic()
              ? Theme.of(context).colorScheme.secondary.withOpacity(1)
              : Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.search, color: Colors.grey),
          ),
          isDense: isArabic() ? true : false,
          // fillColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          filled: true,
          hintText: S.of(context).search,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            fontSize: 15,
          ),
          errorStyle: const TextStyle(color: Colors.red),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
            ),
          ),
        ),
      ),
    );
  }
}
