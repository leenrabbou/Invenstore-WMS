// ignore_for_file: must_be_immutable, file_names

import 'package:buymore/main.dart';
import 'package:flutter/material.dart';

class ProfileContainer extends StatelessWidget {
  ProfileContainer({super.key, required this.text, required this.title});
  String title, text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isArabic() ? 0 : 80,
        right: isArabic() ? 80 : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.blueGrey,
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          FittedBox(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
