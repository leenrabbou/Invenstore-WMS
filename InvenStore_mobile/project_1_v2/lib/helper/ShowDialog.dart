// ignore_for_file: file_names, use_build_context_synchronously

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Address/CityModel.dart';
import 'package:project_1_v2/Models/Address/ResponseAddState.dart';
import 'package:project_1_v2/Services/Address/AddressServices.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/CustomElevatedButton.dart';
import 'package:project_1_v2/helper/CustomSnackBar.dart';
import 'package:project_1_v2/helper/CustomTextField.dart';
import 'package:project_1_v2/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ShowDialog {
  void addStateDialog(BuildContext context, {required CityModel city}) {
    final TextEditingController nameArController = TextEditingController();
    final TextEditingController nameEnController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    bool isLoading = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Form(
              key: formKey,
              child: Dialog(
                backgroundColor: Theme.of(context).colorScheme.background,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  height: 400,
                  width: 480,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S().addState,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: isArabic() ? 0 : 300,
                            left: isArabic() ? 300 : 0,
                            bottom: 15,
                          ),
                          child: Divider(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimary.withOpacity(0.5),
                          ),
                        ),
                        CustomTextField(
                          text: S().stateNameEn,
                          hint: S().enterstateNameEn,
                          controller: nameEnController,
                          left: 0,
                          right: 0,
                          top: isArabic() ? 0 : 10,
                          bottom: 0,
                          height: isArabic() ? 100 : 100,
                          width: 400,
                          maxLines: false,
                          errorMsg: S.of(context).required,
                          fillColor: null,
                          prefix: null,
                          suffix: false,
                          obscure: false,
                          inputFormatter: null,
                          maxLength: null,
                        ),
                        CustomTextField(
                          text: S().stateNameAr,
                          hint: S().enterstateNameAr,
                          controller: nameArController,
                          left: 0,
                          right: 0,
                          top: isArabic() ? 0 : 10,
                          bottom: 0,
                          height: isArabic() ? 100 : 100,
                          width: 400,
                          maxLines: false,
                          errorMsg: S.of(context).required,
                          fillColor: null,
                          prefix: null,
                          suffix: false,
                          obscure: false,
                          inputFormatter: null,
                          maxLength: null,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                height: 40,
                                width: 100,
                                left: isArabic() ? 30 : 0,
                                right: isArabic() ? 0 : 30,
                                top: 5,
                                bottom: 10,
                                textSize: isArabic() ? 15 : 15,
                                color: Theme.of(context).colorScheme.background,
                                textcolor: Theme.of(
                                  context,
                                ).colorScheme.secondary,
                                elevation: 0,
                                child: Text(
                                  S.of(context).cancel,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              CustomElevatedButton(
                                onPressed: isLoading
                                    ? () {}
                                    : () async {
                                        final locale =
                                            Provider.of<LocalizationProvider>(
                                              context,
                                              listen: false,
                                            ).language!;
                                        setState(() {
                                          isLoading = true;
                                        });
                                        if (formKey.currentState!.validate()) {
                                          try {
                                            ResponseAddStateModel response =
                                                await AddressServices()
                                                    .addStateService(
                                                      nameEnController.text
                                                          .toString(),
                                                      nameArController.text
                                                          .toString(),
                                                      city.id,
                                                      locale,
                                                    );

                                            if (response.status == 1) {
                                              setState(() async {
                                                await AddressServices()
                                                    .allStatesForCityService(
                                                      city.id,
                                                      locale,
                                                    );

                                                statesForCityList.add(
                                                  response.data,
                                                );
                                              });

                                              CustomSnackBar().showToast(
                                                response.message,
                                              );
                                            } else if (response.status == 0) {
                                              String errorMessage =
                                                  S().unknownErrorOccurred;

                                              CustomSnackBar().showToast(
                                                errorMessage,
                                              );
                                            } else {
                                              CustomSnackBar().showToast(
                                                S().unknownErrorOccurred,
                                              );
                                            }
                                          } catch (e) {
                                            if (kDebugMode) {
                                              print(e);
                                              print(4444);
                                            }
                                          }
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.pop(context);
                                        }
                                      },
                                height: 40,
                                width: 100,
                                left: 0,
                                right: 0,
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
                                        S().save,
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
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
