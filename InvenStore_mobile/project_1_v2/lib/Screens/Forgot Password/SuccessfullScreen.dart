// ignore_for_file: file_names

import 'package:project_1_v2/Screens/SignInScreen.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/CustomElevatedButton.dart';
import 'package:flutter/material.dart';

class SuccessfulScreen extends StatelessWidget {
  const SuccessfulScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              Image.asset('images/checked.png', width: 200, height: 200),
              const SizedBox(height: 10),
              Text(
                S().allDone,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                S().resetSuccessfully,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 15),
              CustomElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const SignInScreen();
                      },
                    ),
                  );
                },
                height: 50,
                width: 500,
                left: 30,
                right: 30,
                top: 5,
                bottom: 0,
                textSize: 18,
                color: const Color.fromARGB(255, 104, 168, 221),
                elevation: 3,
                textcolor: Colors.white,
                child: Text(
                  S().goToLoginPage,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
