// ignore_for_file: file_names, use_build_context_synchronously

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Screens/BannedScreen.dart';
import 'package:project_1_v2/Screens/Forgot%20Password/ForgotPasswordScreen.dart';
import 'package:project_1_v2/Screens/Home.dart';
import 'package:project_1_v2/Screens/Verification/VerificationRequiredScreen.dart';
import 'package:project_1_v2/Services/Address/AddressServices.dart';
import 'package:project_1_v2/Services/LogIn/LogInService.dart';
import 'package:project_1_v2/Services/Warehouse/DestructionServices.dart';
import 'package:project_1_v2/Services/Warehouse/ProfileService.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:project_1_v2/helper/CustomElevatedButton.dart';
import 'package:project_1_v2/helper/CustomSnackBar.dart';
import 'package:project_1_v2/helper/CustomTextField.dart';
import 'package:project_1_v2/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _myBox = Hive.box('mainBox');

  void storeData() {
    _myBox.put('onBoard', false);
  }

  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LocalizationProvider>(context);
    return DoubleTapToExit(
      snackBar: SnackBar(
        content: Center(
          child: Text(
            S().PressagaintoExit,
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary.withAlpha(200),
        shape: const StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 20, left: 70, right: 70),
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Form(
          key: formKey,
          child: SafeArea(
            child: Center(
              child: Form(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0, bottom: 20),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.24,
                          width: MediaQuery.of(context).size.height * 0.5,
                          child: Image.asset(
                            'images/Picsart_24-04-28_16-51-13-182.png',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 20,
                        left: isArabic() ? 0 : 20,
                        right: isArabic() ? 20 : 0,
                      ),
                      child: Text(
                        S().welcomeBack,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 35,
                        ),
                      ),
                    ),
                    CustomTextField(
                      text: S().email_Address,
                      hint: S().enter_email,
                      controller: emailController,
                      width: 100,
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
                    CustomTextField(
                      text: S().password,
                      hint: S().enter_password,
                      controller: passwordController,
                      width: 100,
                      height: 100,
                      left: 20,
                      right: 20,
                      top: 0,
                      bottom: 0,
                      maxLines: false,
                      errorMsg: S().feild_required,
                      fillColor: Theme.of(context).colorScheme.background,
                      prefix: const Icon(Icons.lock, color: Color(0xff69a8dd)),
                      suffix: true,
                      obscure: true,
                      inputFormatter: null,
                      maxLength: null,
                    ),
                    CustomElevatedButton(
                      onPressed: isLoading
                          ? () {}
                          : () async {
                              final locale = Provider.of<LocalizationProvider>(
                                context,
                                listen: false,
                              ).language!;
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  setState(() {});
                                  int response;
                                  response = await LogInService().logInService(
                                    emailController.text,
                                    passwordController.text,
                                    locale,
                                  );
                                  if (response == 200) {
                                    if (verified) {
                                      await ProfileServices()
                                          .showProfileWarehouseService(locale);
                                      await DestructionServices()
                                          .getAllDestructionCausesService(
                                            locale,
                                          );
                                      await AddressServices().allCitiesService(
                                        locale,
                                      );

                                      CustomSnackBar().showToast(S().welcome);
                                    }
                                    if (!context.mounted) {
                                      return;
                                    }

                                    verified
                                        ? Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return const HomeScreen();
                                              },
                                            ),
                                          )
                                        : Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return VerificationRequiredScreen(
                                                  email: emailController.text,
                                                );
                                              },
                                            ),
                                          );

                                    storeData();
                                    setState(() {});
                                  } else if (response == 401) {
                                    CustomSnackBar().showToast(
                                      'user email & password does not match with our record.',
                                    );
                                  } else if (response == 404) {
                                    CustomSnackBar().showToast(
                                      'User not found.',
                                    );
                                  } else if (response == 403) {
                                    CustomSnackBar().showToast(
                                      'Sorry, your account has been banned',
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return const BannedScreen();
                                        },
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (kDebugMode) {
                                    print(e);
                                  }
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                      height: 50,
                      width: 100,
                      left: 30,
                      right: 30,
                      top: 30,
                      bottom: 10,
                      textSize: 20,
                      color: const Color.fromARGB(255, 104, 168, 221),
                      elevation: 3,
                      textcolor: Colors.white,
                      child: isLoading
                          ? SpinKitThreeInOut(
                              color: Theme.of(context).colorScheme.background,
                              size: 20,
                            )
                          : Text(
                              S().signin,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const ForgotPasswordScreen();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              S().forgotPassword,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 85, 139, 184),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              languageProvider.setLanguage(const Locale('en'));

                              setState(() {});
                            },
                            child: Text(
                              S().english,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              languageProvider.setLanguage(const Locale('ar'));

                              setState(() {});
                            },
                            child: Text(
                              S().arabic,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
