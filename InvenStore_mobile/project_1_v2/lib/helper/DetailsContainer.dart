// ignore_for_file: file_names, must_be_immutable

import 'package:project_1_v2/main.dart';
import 'package:flutter/material.dart';

class DetailsContainer extends StatelessWidget {
  DetailsContainer({
    super.key,
    required this.title,
    required this.text,
    required this.height,
    required this.width,
  });
  String title, text;
  double height, width;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Theme.of(context).colorScheme.onSurface,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      height: height,
      width: width,
      child: Padding(
        padding: EdgeInsets.only(
          left: isArabic() ? 0 : 5,
          right: isArabic() ? 5 : 0,
          top: 2,
          bottom: 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 130,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(
                    context,
                  ).colorScheme.onPrimary.withOpacity(0.5),
                ),
              ),
            ),
            const SizedBox(height: 2),
            FittedBox(child: Text(text, style: const TextStyle(fontSize: 15))),
          ],
        ),
      ),
    );
  }
}
