// ignore_for_file: no_logic_in_create_state, must_be_immutable, file_names

import 'package:flutter/material.dart';

class IntroScreens extends StatefulWidget {
  IntroScreens(
      {super.key,
      required this.image,
      required this.title,
      required this.description});
  String image, title, description;

  @override
  State<IntroScreens> createState() =>
      _IntroScreensState(image: image, title: title, description: description);
}

class _IntroScreensState extends State<IntroScreens> {
  _IntroScreensState(
      {required this.image, required this.title, required this.description});
  String image, title, description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Column(
        children: [
          Image.asset(
            image,
            height: MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          FittedBox(
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
