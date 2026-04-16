// ignore_for_file: use_build_context_synchronously

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Responses/ResponseModel.dart';
import 'package:buymore/Screens/Forgot%20Password/SuccessfullScreen.dart';
import 'package:buymore/Services/Forgot%20Password/PasswordServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomSnackBar.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen(
      {super.key, required this.email, required this.otp});
  final String email, otp;

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String confirmMsg = S().feild_required;

  void onPressed() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      if (_passwordController.text == _confirmPasswordController.text) {
        final locale =
            Provider.of<LocalizationProvider>(context, listen: false).language!;
        ResponseModel response = await PasswordServices().resetPassword(
            widget.email, widget.otp, _passwordController.text, locale);

        setState(() {
          isLoading = false;
        });
        response.status == 1
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SuccessfulScreen();
                  },
                ),
              )
            : CustomSnackBar().showToast(response.message);
      } else {
        setState(() {
          confirmMsg = 'Passwords do not match';
          formKey.currentState!.validate();
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
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
              Center(
                child: Image.asset(
                  'images/SetNewPassword.png',
                  width: 500,
                  height: 500,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S().setNewPassword,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    S().mustBeAtLeast8Characters,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  CustomTextField(
                    text: S().newPassword,
                    hint: S().enterNewPassword,
                    controller: _passwordController,
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
                      Icons.lock,
                      color: Color(0xff69a8dd),
                    ),
                    suffix: true,
                    obscure: true,
                    inputFormatter: null,
                    maxLength: null,
                  ),
                  CustomTextField(
                    text: S().confirmPassword,
                    hint: S().enter_password,
                    controller: _confirmPasswordController,
                    width: 500,
                    height: 100,
                    left: 20,
                    right: 20,
                    top: 0,
                    bottom: 0,
                    maxLines: false,
                    errorMsg: confirmMsg,
                    fillColor: Theme.of(context).colorScheme.background,
                    prefix: const Icon(
                      Icons.lock,
                      color: Color(0xff69a8dd),
                    ),
                    suffix: true,
                    obscure: true,
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
