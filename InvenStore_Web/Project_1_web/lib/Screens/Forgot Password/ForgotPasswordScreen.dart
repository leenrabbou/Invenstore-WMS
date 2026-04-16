// ignore_for_file: use_build_context_synchronously

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Responses/ResponseModel.dart';
import 'package:buymore/Screens/Forgot%20Password/ResetPasswordScreen.dart';
import 'package:buymore/Services/Forgot%20Password/PasswordServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomSnackBar.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  void onPressed() async {
    setState(() {
      isLoading = true;
    });

    if (formKey.currentState!.validate()) {
      final locale =
          Provider.of<LocalizationProvider>(context, listen: false).language!;
      ResponseModel response = await PasswordServices()
          .getResetPasswordCode(_emailController.text, locale);

      response.status == 1
          ? Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
              return ResetPasswordScreen(
                email: _emailController.text,
              );
            }))
          : CustomSnackBar().showToast(response.message);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'images/Forgot password-pana (1).png',
                width: 500,
                height: 500,
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S().forgotPassword,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    S().NoWorriesWeSendYouResetInstructions,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    text: S().enterEmail,
                    hint: S().email_Address,
                    controller: _emailController,
                    width: 500,
                    height: 100,
                    left: 20,
                    right: 20,
                    top: 0,
                    bottom: 0,
                    maxLines: false,
                    errorMsg: S().feild_required,
                    fillColor: null,
                    prefix: const Icon(
                      Icons.email_outlined,
                      color: Color(0xff69a8dd),
                    ),
                    suffix: false,
                    obscure: false,
                    inputFormatter: null,
                    maxLength: null,
                  ),
                  CustomElevatedButton(
                    onPressed: isLoading ? () {} : onPressed,
                    height: 50,
                    width: 300,
                    left: 30,
                    right: 30,
                    top: 5,
                    bottom: 0,
                    textSize: 18,
                    color: const Color.fromARGB(255, 104, 168, 221),
                    elevation: 3,
                    textcolor: Colors.white,
                    child: isLoading
                        ? SpinKitThreeInOut(
                            color: Theme.of(context).colorScheme.background,
                            size: 20,
                          )
                        : Text(
                            S().resetPassword,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
