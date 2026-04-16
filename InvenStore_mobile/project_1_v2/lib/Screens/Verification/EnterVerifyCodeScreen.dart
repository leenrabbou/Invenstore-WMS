// ignore_for_file: file_names, use_build_context_synchronously

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Responses/ResponseModel.dart';
import 'package:project_1_v2/Screens/Home.dart';
import 'package:project_1_v2/Screens/SignInScreen.dart';
import 'package:project_1_v2/Services/Address/AddressServices.dart';
import 'package:project_1_v2/Services/LogIn/LogOutService.dart';
import 'package:project_1_v2/Services/Verification/VerificationServices.dart';
import 'package:project_1_v2/Services/Warehouse/DestructionServices.dart';
import 'package:project_1_v2/Services/Warehouse/ProfileService.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/CodeTextField.dart';
import 'package:project_1_v2/helper/CustomElevatedButton.dart';
import 'package:project_1_v2/helper/CustomSnackBar.dart';
import 'package:project_1_v2/main.dart';
import 'package:flutter/foundation.dart';
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
  bool isLoading = false, isLoading2 = false, isLoadingLogOut = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
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
                Image.asset('images/Verifyemail.png', width: 500, height: 300),
                const SizedBox(height: 10),
                Text(
                  S().verifyYourEmail,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CodeTextField(
                      textController: code1Controller,
                      isLast: false,
                    ),
                    CodeTextField(
                      textController: code2Controller,
                      isLast: false,
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
                      ResponseModel response = await VerificationServices()
                          .getVerificationCode(locale);
                      if (response.status == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return EnterVerifyCodeScreen(email: widget.email);
                            },
                          ),
                        );

                        CustomSnackBar().showToast(response.message);
                      } else {
                        CustomSnackBar().showToast(S().unknownErrorOccurred);
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

                            ResponseModel response =
                                await VerificationServices()
                                    .sendVerificationCode(
                                      code1Controller.text +
                                          code2Controller.text +
                                          code3Controller.text +
                                          code4Controller.text +
                                          code5Controller.text +
                                          code6Controller.text,
                                      locale,
                                    );
                            setState(() {
                              isLoading = false;
                            });
                            response.status == 1
                                ? showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return WillPopScope(
                                        onWillPop: () async => false,
                                        child: AlertDialog(
                                          title: Column(
                                            children: [
                                              Image.asset(
                                                'images/checked.png',
                                                width: 100,
                                                height: 100,
                                              ),
                                              Text(
                                                S().verified,
                                                style: TextStyle(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.secondary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          content: Text(
                                            S().youremailhasbeensuccessfullyverified,
                                            style: TextStyle(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.secondary,
                                            ),
                                          ),
                                          actions: [
                                            Center(
                                              child: CustomElevatedButton(
                                                onPressed: isLoading2
                                                    ? () {}
                                                    : () async {
                                                        setState(() {
                                                          isLoading2 = true;
                                                        });
                                                        await ProfileServices()
                                                            .showProfileWarehouseService(
                                                              locale,
                                                            );
                                                        await DestructionServices()
                                                            .getAllDestructionCausesService(
                                                              locale,
                                                            );
                                                        await AddressServices()
                                                            .allCitiesService(
                                                              locale,
                                                            );
                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (
                                                                  BuildContext
                                                                  context,
                                                                ) {
                                                                  return const HomeScreen();
                                                                },
                                                          ),
                                                        );
                                                      },
                                                height: 50,
                                                width: 200,
                                                left: 0,
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                textSize: 15,
                                                color: const Color.fromARGB(
                                                  255,
                                                  104,
                                                  168,
                                                  221,
                                                ),
                                                elevation: 3,
                                                textcolor: Colors.white,
                                                child: isLoading2
                                                    ? SpinKitThreeInOut(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .background,
                                                        size: 20,
                                                      )
                                                    : Text(
                                                        S().gotoHomePage,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
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
                          S().confirm,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final locale = Provider.of<LocalizationProvider>(
                          context,
                          listen: false,
                        ).language!;

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.background,
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              content: Text(S().logOutMsg, maxLines: 2),
                              actions: [
                                CustomElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  height: 40,
                                  width: 60,
                                  left: 50,
                                  right: 50,
                                  top: 5,
                                  bottom: 10,
                                  textSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.background,
                                  textcolor: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  elevation: 0,
                                  child: Text(
                                    S.of(context).no,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                CustomElevatedButton(
                                  onPressed: isLoadingLogOut
                                      ? () {}
                                      : () async {
                                          try {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            int response;
                                            response = await LogOutService()
                                                .logOut(locale);

                                            setState(() {
                                              isLoading = false;
                                            });
                                            if (response == 200) {
                                              if (!context.mounted) {
                                                return;
                                              }
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (BuildContext context) {
                                                    return const SignInScreen();
                                                  },
                                                ),
                                              );
                                            } else {
                                              CustomSnackBar().showToast(
                                                S().checkYourInternetConnectionAndTryAgain,
                                              );
                                            }
                                          } catch (e) {
                                            if (kDebugMode) {
                                              print(e);
                                            }
                                          }
                                          if (!context.mounted) {
                                            return;
                                          }
                                        },
                                  height: 40,
                                  width: 60,
                                  left: isArabic() ? 50 : 0,
                                  right: isArabic() ? 0 : 50,
                                  top: 5,
                                  bottom: 10,
                                  textSize: isArabic() ? 15 : 15,
                                  color: const Color.fromARGB(
                                    255,
                                    29,
                                    104,
                                    165,
                                  ),
                                  elevation: 5,
                                  textcolor: Colors.white,
                                  child: isLoadingLogOut
                                      ? SpinKitThreeInOut(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.background,
                                          size: 20,
                                        )
                                      : Text(
                                          S().yes,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        S.of(context).logout,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
