// ignore_for_file: file_names, use_build_context_synchronously

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Screens/BannedScreen.dart';
import 'package:buymore/Screens/Forgot%20Password/ForgotPasswordScreen.dart';
import 'package:buymore/Screens/Manager/Home.dart';
import 'package:buymore/Screens/Verification/VerificationRequiredScreen.dart';
import 'package:buymore/Services/Address/AddressServices.dart';
import 'package:buymore/Services/LogIn/LogInService.dart';
import 'package:buymore/Services/Manager/CategoriesServices.dart';
import 'package:buymore/Services/Manager/ManufacturerServices.dart';
import 'package:buymore/Services/Manager/ShippingCompanyServices.dart';
import 'package:buymore/Services/Warehouse/DestructionServices.dart';
import 'package:buymore/Services/Warehouse/ProfileService.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomSnackBar.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomTextField.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool obscure = true;
  bool isLoading = false;
  final TextEditingController _passwordController =
      TextEditingController(text: 'password');
  final TextEditingController _emailController =
      TextEditingController(text: 'leen@gmail.com');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _myBox = Hive.box('mainBox');
  void storeData() {
    _myBox.put('SignIn', true);
    _myBox.put('token', token);
  }

  void onPressed() async {
    setState(() {
      isLoading = true;
    });

    if (formKey.currentState!.validate()) {
      final locale =
          Provider.of<LocalizationProvider>(context, listen: false).language!;
      try {
        int response = await LogInService().logInService(
            _emailController.text, _passwordController.text, locale);

        if (response == 200) {
          if (verified) {
            role == 'admin'
                ? await ProfileServices().showProfileManagerService(locale)
                : await ProfileServices().showProfileWarehouseService(locale);
            await AddressServices().allCitiesService(locale);
            permissionsMap['destruction.index'] == true
                ? await DestructionServices()
                    .getAllDestructionCausesService(locale)
                : null;
            permissionsMap['category.index'] == true
                ? await CategoriesService()
                    .showAllCategoriesService(null, locale)
                : null;
            permissionsMap['manufacturer.index'] == true
                ? await ManufacturerServices()
                    .showAllManufacturersService(null, locale)
                : null;
            await AddressServices().allStatesService(locale);
            permissionsMap['shippingCompany.index'] == true
                ? await ShippingCompanyServices()
                    .showAllShippingCompaniesService(null, locale)
                : null;
            storeData();

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
                      return const Home();
                    },
                  ),
                )
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return VerificationRequiredScreen(
                        email: _emailController.text,
                      );
                    },
                  ),
                );
        } else if (response == 401) {
          CustomSnackBar().showToast(
              'user email & password does not match with our record.');
        } else if (response == 404) {
          CustomSnackBar().showToast('User not found.');
        } else if (response == 403) {
          CustomSnackBar().showToast('Sorry, your account has been banned');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const BannedScreen();
              },
            ),
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            isArabic()
                ? 'images/backgroundArabic.jpg'
                : 'images/backgroundEn.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 50, left: isArabic() ? 0 : 45, right: isArabic() ? 45 : 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: GlassContainer(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.32,
                borderRadius: BorderRadius.circular(20),
                borderColor: Colors.white.withOpacity(0.10),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.30),
                    Colors.white.withOpacity(0.10)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderGradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.60),
                    Colors.white.withOpacity(0.10),
                    Colors.lightBlueAccent.withOpacity(0.05),
                    Colors.lightBlueAccent.withOpacity(0.6)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.0, 0.39, 0.40, 1.0],
                ),
                blur: 15.0,
                borderWidth: 1.5,
                elevation: 3.0,
                isFrostedGlass: true,
                shadowColor: Colors.black.withOpacity(0.20),
                alignment: Alignment.center,
                frostedOpacity: 0.2,
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: isArabic() ? 25 : 30,
                              left: isArabic() ? 0 : 25,
                              right: isArabic() ? 25 : 0),
                          child: Row(
                            children: [
                              Text(
                                S.of(context).signin,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: isArabic() ? 30 : 40,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          text: S.of(context).email_Address,
                          hint: S.of(context).enter_email,
                          controller: _emailController,
                          // controller:
                          //     TextEditingController(text: 'leen@gmail.com'),

                          width: 400,
                          height: 100,
                          left: 20,
                          right: 20,
                          top: 10,
                          bottom: 0,
                          maxLines: false,
                          errorMsg: S.of(context).email_cannot_be_empty,
                          fillColor: Colors.white.withOpacity(0.3),
                          prefix: const Icon(
                            Icons.email_outlined,
                            color: Color.fromARGB(255, 29, 104, 165),
                          ),
                          suffix: false,
                          obscure: false,
                          inputFormatter: null,
                          maxLength: null,
                        ),
                        CustomTextField(
                          text: S.of(context).password,
                          hint: S.of(context).enter_password,
                          controller: _passwordController,
                          // controller: TextEditingController(text: 'password'),
                          width: 400,
                          height: 100,
                          left: 20,
                          right: 20,
                          top: 0,
                          bottom: 0,
                          maxLines: false,
                          errorMsg: S.of(context).feild_required,
                          fillColor: Colors.white.withOpacity(0.3),
                          prefix: const Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 29, 104, 165),
                          ),
                          suffix: true,
                          obscure: true,
                          inputFormatter: null,
                          maxLength: null,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: isArabic() ? 0 : 220,
                              right: isArabic() ? 220 : 0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return const ForgotPasswordScreen();
                              }));
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: FittedBox(
                                child: Text(
                                  S.of(context).forgotPassword,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomElevatedButton(
                            onPressed: isLoading ? () {} : onPressed,
                            height: 48,
                            width: MediaQuery.of(context).size.width * 0.15,
                            left: 0,
                            right: 0,
                            top: 12,
                            bottom: 0,
                            textSize: isArabic() ? 15 : 18,
                            color: const Color.fromARGB(255, 29, 104, 165),
                            elevation: 5,
                            textcolor: Colors.white,
                            child: isLoading
                                ? SpinKitThreeInOut(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    size: 20,
                                  )
                                : Text(
                                    S.of(context).signin,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  languageProvider
                                      .setLanguage(const Locale('en'));

                                  setState(() {});
                                },
                                child: Text(
                                  S().english,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  languageProvider
                                      .setLanguage(const Locale('ar'));

                                  setState(() {});
                                },
                                child: Text(
                                  S().arabic,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
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
        ],
      ),
    );
  }
}
