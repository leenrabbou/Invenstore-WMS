// ignore_for_file: use_build_context_synchronously

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Responses/ResponseModel.dart';
import 'package:buymore/Screens/Verification/success.dart';
import 'package:buymore/Services/Verification/VerificationServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/CodeTextField.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class EnterVerifyCodeScreen extends StatefulWidget {
  const EnterVerifyCodeScreen({super.key, required this.email});
  final String email;

  @override
  State<EnterVerifyCodeScreen> createState() => _EnterVerifyCodeScreenState();
}

class _EnterVerifyCodeScreenState extends State<EnterVerifyCodeScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController code1Controller = TextEditingController();

  final TextEditingController code2Controller = TextEditingController();

  final TextEditingController code3Controller = TextEditingController();

  final TextEditingController code4Controller = TextEditingController();

  final TextEditingController code5Controller = TextEditingController();

  final TextEditingController code6Controller = TextEditingController();

  bool isLoading = false;
  bool isLoading2 = false;

  @override
  Widget build(BuildContext context) {
    void onPressed() async {
      setState(() {
        isLoading = true;
      });
      if (formKey.currentState!.validate()) {
        final locale =
            Provider.of<LocalizationProvider>(context, listen: false).language!;

        ResponseModel response = await VerificationServices()
            .sendVerificationCode(
                code1Controller.text +
                    code2Controller.text +
                    code3Controller.text +
                    code4Controller.text +
                    code5Controller.text +
                    code6Controller.text,
                locale);
        if (!mounted) return;
        response.status == 1
            ? Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) {
                return Success();
              }))
            : CustomSnackBar().showToast(response.message);
      }

      setState(() {
        isLoading = false;
      });
    }

    return Scaffold(
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
                'images/Verifyemail.png',
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
                    S().verifyYourEmail,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
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
                        textController: code2Controller,
                        isLast: false,
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
                        ResponseModel response = await VerificationServices()
                            .getVerificationCode(locale);
                        if (response.status == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return EnterVerifyCodeScreen(
                                  email: widget.email,
                                );
                              },
                            ),
                          );

                          CustomSnackBar().showToast(response.message);
                        } else {
                          CustomSnackBar().showToast(response.message);
                        }
                      },
                      child: Text(
                        S().resendCode,
                        style: const TextStyle(
                          color: Color.fromARGB(212, 104, 168, 221),
                        ),
                      ),
                    ),
                  ),
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
                            S().confirm,
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
