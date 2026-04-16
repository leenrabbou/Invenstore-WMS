// ignore_for_file: depend_on_referenced_packages

import 'package:project_1_v2/Screens/OnBoarding/OnBoardingScreen.dart';
import 'package:project_1_v2/Screens/SignInScreen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.isViewed});
  final bool isViewed;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSplashScreen(
            backgroundColor: Theme.of(context).colorScheme.background,
            splashIconSize: 400,
            splashTransition: SplashTransition.fadeTransition,
            splash: Center(
              child: Image.asset('images/output-onlinegiftools (1).gif'),
            ),
            nextScreen: widget.isViewed
                ? const SignInScreen()
                : const OnBoardingScreens(),
          ),
          const Align(
            alignment: Alignment(0, 0.45),
            child: Text(
              "InvenStore",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: "Raleway",
                color: Color.fromARGB(255, 104, 168, 221),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
