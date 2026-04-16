import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomSnackBar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:buymore/Screens/Manager/Home.dart';
import 'package:buymore/Services/Address/AddressServices.dart';
import 'package:buymore/Services/Manager/CategoriesServices.dart';
import 'package:buymore/Services/Manager/ManufacturerServices.dart';
import 'package:buymore/Services/Manager/ShippingCompanyServices.dart';
import 'package:buymore/Services/Warehouse/DestructionServices.dart';
import 'package:buymore/Services/Warehouse/ProfileService.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:provider/provider.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                Image.asset(
                  'images/checked.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  S().allDone,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  S().resetSuccessfully,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 15),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomElevatedButton(
                  onPressed: isLoading
                      ? () {}
                      : () async {
                          setState(() {
                            isLoading = true;
                          });

                          final locale = Provider.of<LocalizationProvider>(
                                  context,
                                  listen: false)
                              .language!;
                          try {
                            role == 'warehouse manager' ||
                                    role == 'assistant manager'
                                ? await ProfileServices()
                                    .showProfileWarehouseService(locale)
                                : await ProfileServices()
                                    .showProfileManagerService(locale);
                            await AddressServices().allCitiesService(locale);
                            await DestructionServices()
                                .getAllDestructionCausesService(locale);
                            await CategoriesService()
                                .showAllCategoriesService(null, locale);
                            await ManufacturerServices()
                                .showAllManufacturersService(null, locale);
                            await AddressServices().allStatesService(locale);
                            await ShippingCompanyServices()
                                .showAllShippingCompaniesService(null, locale);

                            CustomSnackBar().showToast(S().welcome);

                            if (!context.mounted) {
                              return;
                            }
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const Home();
                                },
                              ),
                            );
                          } catch (e) {
                            if (kDebugMode) {
                              print(e);
                            }
                          }

                          setState(() {
                            isLoading = false;
                          });
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
                          S().gotoHomePage,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
