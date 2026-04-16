// ignore_for_file: use_build_context_synchronously, file_names

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Responses/ResponseModel.dart';
import 'package:project_1_v2/Screens/Verification/EnterVerifyCodeScreen.dart';
import 'package:project_1_v2/Services/Verification/VerificationServices.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/CustomElevatedButton.dart';
import 'package:project_1_v2/helper/CustomSnackBar.dart';
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('images/Login-amico.png', width: 500, height: 300),
              const SizedBox(height: 10),
              Text(
                S().verificationRequired,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                S().WeNoticedThatYourEmailIsNotVerifiedWithUs,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                S().pleaseTakeAMomentToVerifyYourAccount,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: isLoading
                    ? () {}
                    : () async {
                        final locale = Provider.of<LocalizationProvider>(
                          context,
                          listen: false,
                        ).language!;
                        setState(() {
                          isLoading = true;
                        });
                        ResponseModel response = await VerificationServices()
                            .getVerificationCode(locale);
                        setState(() {
                          isLoading = false;
                        });
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
                            : CustomSnackBar().showToast(
                                S().unknownErrorOccurred,
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
        ),
      ),
    );
  }
}
