// ignore_for_file: file_names, use_build_context_synchronously

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Responses/ResponseModel.dart';
import 'package:project_1_v2/Screens/Forgot%20Password/ResetPasswordScreen.dart';
import 'package:project_1_v2/Services/Forgot%20Password/PasswordServices.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/CustomElevatedButton.dart';
import 'package:project_1_v2/helper/CustomSnackBar.dart';
import 'package:project_1_v2/helper/CustomTextField.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'images/Forgot password-pana (1).png',
                  width: 500,
                  height: 350,
                ),
                const SizedBox(height: 10),
                Text(
                  S().forgotPassword,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  S().NoWorriesWeSendYouResetInstructions,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 15),
                const SizedBox(height: 0),
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
                  fillColor: Theme.of(context).colorScheme.background,
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
                  onPressed: isLoading
                      ? () {}
                      : () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            final locale = Provider.of<LocalizationProvider>(
                              context,
                              listen: false,
                            ).language!;
                            ResponseModel response = await PasswordServices()
                                .getResetPasswordCode(
                                  _emailController.text,
                                  locale,
                                );
                            response.status == 1
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return ResetPasswordScreen(
                                          email: _emailController.text,
                                        );
                                      },
                                    ),
                                  )
                                : CustomSnackBar().showToast(response.message);
                          }
                          setState(() {
                            isLoading = false;
                          });
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
          ),
        ),
      ),
    );
  }
}
