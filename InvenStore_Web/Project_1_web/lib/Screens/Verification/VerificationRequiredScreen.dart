// ignore_for_file: use_build_context_synchronously

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Responses/ResponseModel.dart';
import 'package:buymore/Screens/Verification/EnterVerifyCodeScreen.dart';
import 'package:buymore/Services/Verification/VerificationServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class VerificationRequiredScreen extends StatefulWidget {
  const VerificationRequiredScreen({super.key, required this.email});
  final String email;

  @override
  State<VerificationRequiredScreen> createState() =>
      _VerificationRequiredScreenState();
}

class _VerificationRequiredScreenState
    extends State<VerificationRequiredScreen> {
  bool isLoading = false;

  void onPressed() async {
    setState(() {
      isLoading = true;
    });
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    ResponseModel response =
        await VerificationServices().getVerificationCode(locale);
    response.status == 1
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return EnterVerifyCodeScreen(
                  email: widget.email,
                );
              },
            ),
          )
        : CustomSnackBar().showToast(response.message);

    setState(() {
      isLoading = false;
    });
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/Login-amico.png',
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
                  S().verificationRequired,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  S().WeNoticedThatYourEmailIsNotVerifiedWithUs,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 15),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  S().pleaseTakeAMomentToVerifyYourAccount,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(
                  height: 20,
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
                          S().getVerificationEmail,
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
    );
  }
}
