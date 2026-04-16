import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Screens/SignInScreen.dart';
import 'package:project_1_v2/Services/LogIn/LogOutService.dart';
import 'package:project_1_v2/Theme/Theme_Provider.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/CustomElevatedButton.dart';
import 'package:project_1_v2/helper/CustomSnackBar.dart';
import 'package:project_1_v2/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final locale = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    ).language!;
    final languageProvider = Provider.of<LocalizationProvider>(context);
    Locale? value = languageProvider.language;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          S().settings,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.language, size: 20),
                    const SizedBox(width: 5),
                    Text(
                      S.of(context).language,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                DropdownButton(
                  value: value,
                  items: [
                    DropdownMenuItem(
                      value: const Locale('en'),
                      child: Text(
                        S().english,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    DropdownMenuItem(
                      value: const Locale('ar'),
                      child: Text(
                        S().arabic,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                  onChanged: (Locale? locale) {
                    languageProvider.setLanguage(locale);

                    setState(() {
                      value = locale;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.dark_mode, size: 20),
                    const SizedBox(width: 5),
                    Text(
                      S.of(context).darkTheme,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                FlutterSwitch(
                  width: 35,
                  height: 20,
                  toggleSize: 10,
                  activeColor: const Color.fromARGB(255, 104, 168, 221),
                  value: themeProvider.darkTheme,
                  onToggle: (value) {
                    themeProvider.setTheme(value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Theme.of(context).colorScheme.background,
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
                          color: Theme.of(context).colorScheme.background,
                          textcolor: Theme.of(context).colorScheme.secondary,
                          elevation: 0,
                          child: Text(
                            S.of(context).no,
                            style: const TextStyle(
                              fontSize: 15,
                              // color: Colors.white,
                            ),
                          ),
                        ),
                        CustomElevatedButton(
                          onPressed: isLoading
                              ? () {}
                              : () async {
                                  try {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    int response;
                                    response = await LogOutService().logOut(
                                      locale,
                                    );

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
                          color: const Color.fromARGB(255, 29, 104, 165),
                          elevation: 5,
                          textcolor: Colors.white,
                          child: isLoading
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
              child: Row(
                children: [
                  const Icon(Icons.logout, size: 20, color: Colors.red),
                  const SizedBox(width: 5),
                  Text(
                    S.of(context).logout,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
