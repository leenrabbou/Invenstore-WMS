// ignore_for_file: use_build_context_synchronously

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Responses/ResponseModel.dart';
import 'package:buymore/Screens/Forgot%20Password/SetNewPasswordScreen.dart';
import 'package:buymore/Services/Forgot%20Password/PasswordServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/CodeTextField.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomSnackBar.dart';
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

  void onPressed() async {
    setState(() {
      isLoading = true;
    });
    if (formKey.currentState!.validate()) {
      final locale =
          Provider.of<LocalizationProvider>(context, listen: false).language!;
      String otp = code1Controller.text +
          code2Controller.text +
          code3Controller.text +
          code4Controller.text +
          code5Controller.text +
          code6Controller.text;
      ResponseModel response = await PasswordServices()
          .sendResetPasswordCode(widget.email, otp, locale);
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
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: null,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'images/Reset password-pana.png',
                width: 600,
                height: 600,
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S().resetPassword,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    S().pleaseEnterTheCodeSentToYourEmail,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.email,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      CodeTextField(
                        textController: code1Controller,
                        isLast: false,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CodeTextField(
                        isLast: false,
                        textController: code2Controller,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CodeTextField(
                        textController: code3Controller,
                        isLast: false,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CodeTextField(
                        textController: code4Controller,
                        isLast: false,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CodeTextField(
                        textController: code5Controller,
                        isLast: false,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CodeTextField(
                        textController: code6Controller,
                        isLast: true,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        final locale = Provider.of<LocalizationProvider>(
                                context,
                                listen: false)
                            .language!;
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
                                left: 30, right: 30, top: 15, bottom: 15),
                            child: Text(
                              'check your email, we send code again',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 15),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  CustomElevatedButton(
                    onPressed: isLoading ? () {} : onPressed,
                    height: 50,
                    width: 300,
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
            ],
          ),
        ),
      ),
    );
  }
}
