// ignore_for_file: file_names

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Address/CityModel.dart';
import 'package:buymore/Models/Address/StateModel.dart';
import 'package:buymore/Services/Address/AddressServices.dart';
import 'package:buymore/Services/Manager/ShippingCompanyServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomSnackBar.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomTextField.dart';
import 'package:buymore/helper/Manager/ShowDialog/ShowDialog.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ShippingCompanyShowDialog {
  void shippingCompanyDialog(BuildContext context,
      {required bool edit, required int shippingCompanyId}) {
    final TextEditingController nameArController = TextEditingController();
    final TextEditingController nameEnController = TextEditingController();
    final TextEditingController streetNameEnController =
        TextEditingController();
    final TextEditingController streetNameArController =
        TextEditingController();
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    CityModel intialValue = allCitiesList.first;
    CityModel cityValue = intialValue;
    bool dropdownStateEdit = false;
    bool isPressed = false, addAbility = false;
    bool isLoading = false;
    StateModel? stateValue;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Form(
              key: key,
              child: Dialog(
                backgroundColor: Theme.of(context).colorScheme.background,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  height: 600,
                  width: 600,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 40.0, left: 40, right: 40, bottom: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            edit
                                ? S().editShippingCompany
                                : S().addShippingCompany,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: isArabic() ? 0 : 300,
                                left: isArabic() ? 300 : 0,
                                bottom: 15),
                            child: Divider(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.5),
                            ),
                          ),
                          CustomTextField(
                            text: S.of(context).shippingCompanyNameEn,
                            hint: S.of(context).entershippingCompanyNameEn,
                            controller: nameEnController,
                            left: 0,
                            right: 0,
                            top: isArabic() ? 0 : 10,
                            bottom: 0,
                            height: isArabic() ? 100 : 100,
                            width: 500,
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
                            text: S.of(context).shippingCompanyNameAr,
                            hint: S.of(context).entershippingCompanyNameAr,
                            controller: nameArController,
                            left: 0,
                            right: 0,
                            top: isArabic() ? 0 : 10,
                            bottom: 0,
                            height: isArabic() ? 100 : 100,
                            width: 500,
                            maxLines: false,
                            errorMsg: S.of(context).required,
                            fillColor: null,
                            prefix: null,
                            suffix: false,
                            obscure: false,
                            inputFormatter: null,
                            maxLength: null,
                          ),
                          Row(
                            children: [
                              Text(
                                S.of(context).city,
                                style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              const SizedBox(
                                width: 270,
                              ),
                              Text(
                                S.of(context).state,
                                style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 140,
                                child: DropdownButton<CityModel>(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.5),
                                  ),
                                  iconSize: 36,
                                  isExpanded: true,
                                  value: cityValue,
                                  onChanged: (CityModel? value) async {
                                    setState(() {
                                      cityValue = value!;
                                      addAbility = true;
                                    });
                                    final locale =
                                        Provider.of<LocalizationProvider>(
                                                context,
                                                listen: false)
                                            .language!;
                                    await AddressServices()
                                        .allStatesForCityService(
                                            cityValue.id, locale);
                                    statesForCityList.isNotEmpty
                                        ? setState(() {
                                            stateValue =
                                                statesForCityList.first;
                                            isPressed = true;
                                          })
                                        : setState(() {
                                            isPressed = false;
                                          });
                                  },
                                  items: allCitiesList
                                      .map<DropdownMenuItem<CityModel>>(
                                          (CityModel item) {
                                    return DropdownMenuItem<CityModel>(
                                      value: item,
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  underline: const SizedBox(
                                    width: 120,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 170,
                              ),
                              isPressed && statesForCityList.isNotEmpty
                                  ? SizedBox(
                                      width: 140,
                                      child: DropdownButton<StateModel>(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.5),
                                        ),
                                        iconSize: 36,
                                        isExpanded: true,
                                        value: stateValue,
                                        onChanged: (StateModel? value) {
                                          setState(() {
                                            stateValue = value!;
                                            dropdownStateEdit = true;
                                          });
                                        },
                                        items: statesForCityList
                                            .map<DropdownMenuItem<StateModel>>(
                                                (StateModel item) {
                                          return DropdownMenuItem<StateModel>(
                                            value: item,
                                            child: Text(
                                              item.name,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        underline: const SizedBox(
                                          width: 120,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      S().noAvalibaleStates,
                                    ),
                              const SizedBox(
                                width: 10,
                              ),
                              addAbility
                                  ? IconButton(
                                      onPressed: () {
                                        ShowDialog().addStateDialog(
                                          context,
                                          city: cityValue,
                                        );
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          const Color.fromARGB(
                                              175, 126, 150, 170),
                                        ),
                                        iconColor: MaterialStateProperty.all(
                                            Colors.white),
                                      ),
                                      icon: const Icon(Icons.add),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                          CustomTextField(
                            text: S.of(context).streetNameEn,
                            hint: S.of(context).enterStreetNameEn,
                            controller: streetNameEnController,
                            left: 0,
                            right: 0,
                            top: isArabic() ? 0 : 10,
                            bottom: 0,
                            height: isArabic() ? 100 : 100,
                            width: 500,
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
                            text: S.of(context).streetNameAr,
                            hint: S.of(context).enterStreetNameAr,
                            controller: streetNameArController,
                            left: 0,
                            right: 0,
                            top: isArabic() ? 0 : 10,
                            bottom: 0,
                            height: isArabic() ? 100 : 100,
                            width: 500,
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
                            padding: const EdgeInsets.only(
                              top: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  height: 40,
                                  width: 150,
                                  left: isArabic() ? 50 : 0,
                                  right: isArabic() ? 0 : 50,
                                  top: 2,
                                  bottom: 10,
                                  textSize: isArabic() ? 15 : 15,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  textcolor:
                                      Theme.of(context).colorScheme.secondary,
                                  elevation: 0,
                                  child: Text(
                                    S.of(context).cancel,
                                    style: const TextStyle(
                                      fontSize: 15,
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
                                                      listen: false)
                                                  .language!;
                                          setState(() {
                                            isLoading = true;
                                          });
                                          if (edit) {
                                            dynamic response;
                                            int? newStateValue;
                                            try {
                                              dropdownStateEdit
                                                  ? newStateValue =
                                                      stateValue!.id
                                                  : newStateValue = null;
                                              response =
                                                  await ShippingCompanyServices()
                                                      .editShippingCompanyService(
                                                          nameEnController.text,
                                                          nameArController.text,
                                                          newStateValue,
                                                          streetNameEnController
                                                              .text,
                                                          streetNameArController
                                                              .text,
                                                          shippingCompanyId,
                                                          locale);

                                              if (response.status == 1) {
                                                CustomSnackBar().showToast(
                                                    response.message);
                                              } else if (response.status == 0 &&
                                                  response.message != null) {
                                                String errorMessage = '';
                                                if (response.message!.nameEn
                                                    .isNotEmpty) {
                                                  errorMessage += response
                                                      .message!.nameEn.first;
                                                }
                                                if (response.message!.nameAr
                                                    .isNotEmpty) {
                                                  errorMessage +=
                                                      errorMessage.isNotEmpty
                                                          ? ' and '
                                                          : '';
                                                  errorMessage += response
                                                      .message!.nameAr.first;
                                                }

                                                CustomSnackBar()
                                                    .showToast(errorMessage);
                                              } else {
                                                CustomSnackBar().showToast(
                                                    'Unknown error occurred');
                                              }
                                            } catch (e) {
                                              CustomSnackBar().showToast(
                                                  'Something went wrong: $e');
                                              if (kDebugMode) {
                                                print(e);
                                              }
                                            }
                                            if (!context.mounted) {
                                              return;
                                            }
                                            Navigator.pop(context);
                                          } else {
                                            if (key.currentState!.validate()) {
                                              dynamic response;
                                              try {
                                                response = await ShippingCompanyServices()
                                                    .addShippingCompanyService(
                                                        nameEnController.text,
                                                        nameArController.text,
                                                        stateValue!.id
                                                            .toString(),
                                                        streetNameEnController
                                                            .text,
                                                        streetNameArController
                                                            .text,
                                                        locale);

                                                if (response.status == 1) {
                                                  CustomSnackBar().showToast(
                                                      response.message);
                                                } else if (response.status ==
                                                        0 &&
                                                    response.message != null) {
                                                  String errorMessage = '';
                                                  if (response.message!.nameEn
                                                      .isNotEmpty) {
                                                    errorMessage += response
                                                        .message!.nameEn.first;
                                                  }
                                                  if (response.message!.nameAr
                                                      .isNotEmpty) {
                                                    errorMessage +=
                                                        errorMessage.isNotEmpty
                                                            ? ' and '
                                                            : '';
                                                    errorMessage += response
                                                        .message!.nameAr.first;
                                                  }

                                                  CustomSnackBar()
                                                      .showToast(errorMessage);
                                                } else {
                                                  CustomSnackBar().showToast(
                                                      'Unknown error occurred');
                                                }
                                              } catch (e) {
                                                CustomSnackBar().showToast(
                                                    'Something went wrong: $e');
                                                if (kDebugMode) {
                                                  print(e);
                                                }
                                              }
                                              setState(() {
                                                isLoading = false;
                                              });
                                              if (!context.mounted) {
                                                return;
                                              }
                                              Navigator.pop(context);
                                            }
                                          }
                                        },
                                  height: 40,
                                  width: 150,
                                  left: 0,
                                  right: 0,
                                  top: 2,
                                  bottom: 10,
                                  textSize: isArabic() ? 15 : 15,
                                  color:
                                      const Color.fromARGB(255, 29, 104, 165),
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
                                          S.of(context).save,
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
              ),
            );
          });
        });
  }
}
