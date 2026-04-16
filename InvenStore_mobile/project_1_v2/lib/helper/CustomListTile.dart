// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key, required this.icon, required this.text, required this.title});
  final String title, text;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: icon,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                text,
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.secondary),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Divider(
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.1),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
