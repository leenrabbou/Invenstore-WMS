// ignore_for_file: file_names, use_build_context_synchronously

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Responses/ResponseModel.dart';
import 'package:project_1_v2/Screens/Forgot%20Password/SetNewPasswordScreen.dart';
import 'package:project_1_v2/Services/Forgot%20Password/PasswordServices.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/CodeTextField.dart';
import 'package:project_1_v2/helper/CustomElevatedButton.dart';
import 'package:project_1_v2/helper/CustomSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.email});
  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController code1Controller = TextEditingController();

  final TextEditingController code2Controller = TextEditingController();

  final TextEditingController code3Controller = TextEditingController();

  final TextEditingController code4Controller = TextEditingController();

  final TextEditingController code5Controller = TextEditingController();

  final TextEditingController code6Controller = TextEditingController();
  bool isLoading = false;
  bool showText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'images/Reset password-pana.png',
                  width: 500,
                  height: 300,
                ),
                const SizedBox(height: 10),
                Text(
                  S().resetPassword,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  S().pleaseEnterTheCodeSentToYourEmail,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.email,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CodeTextField(
                      textController: code1Controller,
                      isLast: false,
                    ),
                    CodeTextField(
                      isLast: false,
                      textController: code2Controller,
                    ),
                    CodeTextField(
                      textController: code3Controller,
                      isLast: false,
                    ),
                    CodeTextField(
                      textController: code4Controller,
                      isLast: false,
                    ),
                    CodeTextField(
                      textController: code5Controller,
                      isLast: false,
                    ),
                    CodeTextField(
                      textController: code6Controller,
                      isLast: true,
                    ),
                  ],
                ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      final locale = Provider.of<LocalizationProvider>(
                        context,
                        listen: false,
                      ).language!;
                      ResponseModel response = await PasswordServices()
                          .getResetPasswordCode(widget.email, locale);
                      response.status == 1
                          ? setState(() {
                              showText = true;
                            })
                          : CustomSnackBar().showToast(response.message);
                    },
                    child: Text(
                      S().resendCode,
                      style: const TextStyle(
                        color: Color.fromARGB(212, 104, 168, 221),
                      ),
                    ),
                  ),
                ),
                showText
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                            right: 30,
                            top: 15,
                            bottom: 15,
                          ),
                          child: Text(
                            'check your email, we send code again',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                CustomElevatedButton(
                  onPressed: isLoading
                      ? () {}
                      : () async {
                          setState(() {
                            isLoading = true;
                          });
                          if (formKey.currentState!.validate()) {
                            final locale = Provider.of<LocalizationProvider>(
                              context,
                              listen: false,
                            ).language!;
                            String otp =
                                code1Controller.text +
                                code2Controller.text +
                                code3Controller.text +
                                code4Controller.text +
                                code5Controller.text +
                                code6Controller.text;
                            ResponseModel response = await PasswordServices()
                                .sendResetPasswordCode(
                                  widget.email,
                                  otp,
                                  locale,
                                );
                            setState(() {
                              isLoading = false;
                            });
                            response.status == 2
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return SetNewPasswordScreen(
                                          email: widget.email,
                                          otp: otp,
                                        );
                                      },
                                    ),
                                  )
                                : CustomSnackBar().showToast(response.message);
                          }
                        },
                  height: 50,
                  width: 500,
                  left: 30,
                  right: 30,
                  top: 10,
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
                          S().continu,
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
