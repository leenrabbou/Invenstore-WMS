// ignore_for_file: use_build_context_synchronously

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Address/CityModel.dart';
import 'package:buymore/Models/Address/StateModel.dart';
import 'package:buymore/Models/Manager/ImageModel.dart';
import 'package:buymore/Services/Address/AddressServices.dart';
import 'package:buymore/Models/Manager/category/CategoryModel.dart';
import 'package:buymore/Services/Manager/CategoriesServices.dart';
import 'package:buymore/Services/Manager/SubcategoriesServices.dart';
import 'package:buymore/Services/Warehouse/ProfileService.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomSnackBar.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomTextField.dart';
import 'package:buymore/main.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S().addState,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
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
                                  top: 5,
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
                                          setState(() {
                                            isLoading = true;
                                          });
                                          final locale =
                                              Provider.of<LocalizationProvider>(
                                                      context,
                                                      listen: false)
                                                  .language!;
                                          if (formKey.currentState!
                                              .validate()) {
                                            try {
                                              dynamic response;
                                              response = await AddressServices()
                                                  .addStateService(
                                                      nameEnController.text
                                                          .toString(),
                                                      nameArController.text
                                                          .toString(),
                                                      city.id,
                                                      locale);

                                              if (response.status == 1) {
                                                setState(() async {
                                                  await AddressServices()
                                                      .allStatesForCityService(
                                                          city.id, locale);
                                                });

                                                response.status == 1
                                                    ? statesForCityList.add(
                                                        StateModel(
                                                            name: isArabic()
                                                                ? nameArController
                                                                    .text
                                                                : nameEnController
                                                                    .text,
                                                            id: 0,
                                                            nameAr:
                                                                nameArController
                                                                    .text,
                                                            nameEn:
                                                                nameEnController
                                                                    .text,
                                                            city: city.name,
                                                            cityId: city.id),
                                                      )
                                                    : null;
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
                                  width: 150,
                                  left: 0,
                                  right: 0,
                                  top: 5,
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
              );
            },
          );
        });
  }

  void editProfileDialog(BuildContext context) {
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController ssnController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();

    final TextEditingController passwordController = TextEditingController();
    bool male = false, female = false;
    CityModel intialValue = allCitiesList.first;
    CityModel cityValue = intialValue;
    bool dropdownStateEdit = false;
    DateTime currentDate = DateTime.now();
    bool editdate = false;
    bool isPressed = false, addAbility = false;
    bool isLoading = false;
    StateModel? stateValue;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            final imageProvider =
                Provider.of<ImageModel>(context, listen: false);
            return Dialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: 700,
                width: 800,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 40.0, left: 40, right: 40, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).editProfile,
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        right: 40,
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Consumer<ImageModel>(
                                    builder: (context, model, child) {
                                  return model.pickedImage1 == null
                                      ? CircleAvatar(
                                          radius: 70,
                                          backgroundImage:
                                              AssetImage(defaultImage),
                                        )
                                      : CircleAvatar(
                                          radius: 70,
                                          backgroundImage:
                                              MemoryImage(model.webImage1),
                                        );
                                }),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: imageProvider.pickImage,
                                    child: const Icon(Icons.camera_alt),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 470,
                                  width: 500,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextField(
                                            text: S
                                                .of(context)
                                                .fullName
                                                .toUpperCase(),
                                            hint: S.of(context).enterFullName,
                                            controller: fullNameController,
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                            height: isArabic() ? 100 : 90,
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
                                            text: S
                                                .of(context)
                                                .userName
                                                .toUpperCase(),
                                            hint: S.of(context).enterUserName,
                                            controller: userNameController,
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                            height: isArabic() ? 100 : 90,
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
                                            text: S
                                                .of(context)
                                                .email_Address
                                                .toUpperCase(),
                                            hint: S.of(context).enter_email,
                                            controller: emailController,
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                            height: isArabic() ? 100 : 90,
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
                                            text: S
                                                .of(context)
                                                .phoneNumber
                                                .toUpperCase(),
                                            hint:
                                                S.of(context).enterPhoneNumber,
                                            controller: phoneNumberController,
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 10,
                                            height: isArabic() ? 100 : 90,
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
                                            text: S
                                                .of(context)
                                                .password
                                                .toUpperCase(),
                                            hint: S.of(context).enter_password,
                                            controller: passwordController,
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 10,
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
                                                S.of(context).gender,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 215,
                                              ),
                                              Text(
                                                S.of(context).birthDay,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Theme(
                                                data: Theme.of(context)
                                                    .copyWith(
                                                        unselectedWidgetColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .onBackground),
                                                child: Checkbox(
                                                    value: male,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        if (female == true) {
                                                          female = false;
                                                        }
                                                        male = value!;
                                                      });
                                                    }),
                                              ),
                                              Text(
                                                S.of(context).male,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 40,
                                              ),
                                              Checkbox(
                                                  value: female,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      if (male == true) {
                                                        male = false;
                                                      }
                                                      female = value!;
                                                    });
                                                  }),
                                              Text(
                                                S.of(context).female,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 100,
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  DateTime? pickedDate =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2025),
                                                    builder: (context, child) {
                                                      return Theme(
                                                        data: Theme.of(context)
                                                            .copyWith(
                                                                colorScheme: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .copyWith(
                                                                      onSurface: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .onBackground,
                                                                      background: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .background,
                                                                    )),
                                                        child: child!,
                                                      );
                                                    },
                                                  );
                                                  if (pickedDate != null) {
                                                    setState(() {
                                                      currentDate = pickedDate;
                                                      editdate = true;
                                                    });
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.calendar_month,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                ),
                                              ),
                                              Text(
                                                '$currentDate'.substring(0, 10),
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground),
                                              ),
                                            ],
                                          ),
                                          CustomTextField(
                                            text: S.of(context).ssn,
                                            hint: S.of(context).enterSSN,
                                            controller: ssnController,
                                            left: 0,
                                            right: 0,
                                            top: 10,
                                            bottom: 0,
                                            height: isArabic() ? 100 : 90,
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
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 270,
                                              ),
                                              Text(
                                                S.of(context).state,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 140,
                                                child:
                                                    DropdownButton<CityModel>(
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
                                                  onChanged:
                                                      (CityModel? value) async {
                                                    setState(() {
                                                      cityValue = value!;
                                                      addAbility = true;
                                                    });
                                                    final locale = Provider.of<
                                                                LocalizationProvider>(
                                                            context,
                                                            listen: false)
                                                        .language!;
                                                    await AddressServices()
                                                        .allStatesForCityService(
                                                            cityValue.id,
                                                            locale);
                                                    statesForCityList.isNotEmpty
                                                        ? setState(() {
                                                            stateValue =
                                                                statesForCityList
                                                                    .first;
                                                            isPressed = true;
                                                          })
                                                        : setState(() {
                                                            isPressed = false;
                                                          });
                                                  },
                                                  items: allCitiesList.map<
                                                          DropdownMenuItem<
                                                              CityModel>>(
                                                      (CityModel item) {
                                                    return DropdownMenuItem<
                                                        CityModel>(
                                                      value: item,
                                                      child: Text(
                                                        item.name,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onBackground),
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
                                              isPressed &&
                                                      statesForCityList
                                                          .isNotEmpty
                                                  ? SizedBox(
                                                      width: 120,
                                                      child: DropdownButton<
                                                          StateModel>(
                                                        icon: Icon(
                                                          Icons.arrow_drop_down,
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .secondary
                                                              .withOpacity(0.5),
                                                        ),
                                                        iconSize: 36,
                                                        isExpanded: true,
                                                        value: stateValue,
                                                        onChanged: (StateModel?
                                                            value) {
                                                          setState(() {
                                                            stateValue = value!;
                                                            dropdownStateEdit =
                                                                true;
                                                          });
                                                        },
                                                        items: statesForCityList.map<
                                                                DropdownMenuItem<
                                                                    StateModel>>(
                                                            (StateModel item) {
                                                          return DropdownMenuItem<
                                                              StateModel>(
                                                            value: item,
                                                            child: Text(
                                                              item.name,
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .onBackground),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        underline:
                                                            const SizedBox(
                                                          width: 120,
                                                        ),
                                                      ),
                                                    )
                                                  : Text(
                                                      S().noAvalibaleStates,
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .onBackground),
                                                    ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              addAbility
                                                  ? IconButton(
                                                      onPressed: () {
                                                        addStateDialog(
                                                          context,
                                                          city: cityValue,
                                                        );
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(
                                                          const Color.fromARGB(
                                                              174,
                                                              116,
                                                              166,
                                                              207),
                                                        ),
                                                        iconColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .white),
                                                      ),
                                                      icon:
                                                          const Icon(Icons.add),
                                                    )
                                                  : const SizedBox.shrink(),
                                            ],
                                          ),
                                          CustomTextField(
                                            text: S
                                                .of(context)
                                                .address
                                                .toUpperCase(),
                                            hint: S.of(context).enterAddress,
                                            controller: addressController,
                                            left: 0,
                                            right: 0,
                                            top: 10,
                                            bottom: 10,
                                            height: isArabic() ? 100 : 90,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  imageProvider.emptyImage();
                                                },
                                                height: 40,
                                                width: 150,
                                                left: isArabic() ? 50 : 0,
                                                right: isArabic() ? 0 : 50,
                                                top: 5,
                                                bottom: 10,
                                                textSize: isArabic() ? 15 : 15,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background,
                                                textcolor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
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
                                                        setState(() {
                                                          isLoading = true;
                                                        });
                                                        final locale = Provider
                                                                .of<LocalizationProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                            .language!;
                                                        try {
                                                          dynamic response;
                                                          Uint8List? prImage;
                                                          String? gender;
                                                          String? newDate;
                                                          int? newStateValue;
                                                          if (imageProvider
                                                                  .pickedImage3 !=
                                                              null) {
                                                            prImage =
                                                                imageProvider
                                                                    .webImage3;
                                                          }

                                                          if (female) {
                                                            gender = 'female';
                                                          } else if (male) {
                                                            gender = 'male';
                                                          }
                                                          if (editdate) {
                                                            newDate =
                                                                currentDate
                                                                    .toString()
                                                                    .substring(
                                                                        0, 10);
                                                          }

                                                          dropdownStateEdit
                                                              ? newStateValue =
                                                                  stateValue!.id
                                                              : null;
                                                          response = await ProfileServices()
                                                              .editProfileWarehouseService(
                                                                  prImage,
                                                                  addressController
                                                                      .text,
                                                                  userNameController
                                                                      .text,
                                                                  fullNameController
                                                                      .text,
                                                                  emailController
                                                                      .text,
                                                                  gender,
                                                                  newDate,
                                                                  phoneNumberController
                                                                      .text,
                                                                  newStateValue,
                                                                  locale);

                                                          if (response.status ==
                                                              1) {
                                                            CustomSnackBar()
                                                                .showToast(
                                                                    response
                                                                        .message);
                                                          } else if (response
                                                                      .status ==
                                                                  0 &&
                                                              response.message !=
                                                                  null) {
                                                            String
                                                                errorMessage =
                                                                '';
                                                            if (response
                                                                .message!
                                                                .nameEn
                                                                .isNotEmpty) {
                                                              errorMessage +=
                                                                  response
                                                                      .message!
                                                                      .nameEn
                                                                      .first;
                                                            }
                                                            if (response
                                                                .message!
                                                                .nameAr
                                                                .isNotEmpty) {
                                                              errorMessage +=
                                                                  errorMessage
                                                                          .isNotEmpty
                                                                      ? ' and '
                                                                      : '';
                                                              errorMessage +=
                                                                  response
                                                                      .message!
                                                                      .nameAr
                                                                      .first;
                                                            }
                                                            CustomSnackBar()
                                                                .showToast(
                                                                    errorMessage);
                                                          } else {
                                                            CustomSnackBar()
                                                                .showToast(
                                                                    'Unknown error occurred');
                                                          }
                                                        } catch (e) {
                                                          CustomSnackBar()
                                                              .showToast(
                                                                  'Something went wrong: $e');
                                                          if (kDebugMode) {
                                                            print(e);
                                                          }
                                                        }
                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                        Navigator.pop(context);
                                                        imageProvider
                                                            .emptyImage();
                                                      },
                                                height: 40,
                                                width: 150,
                                                left: 0,
                                                right: 0,
                                                top: 5,
                                                bottom: 10,
                                                textSize: isArabic() ? 15 : 15,
                                                color: const Color.fromARGB(
                                                    255, 29, 104, 165),
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  void editProfileForManagerDialog(BuildContext context) {
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    bool isLoading = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            final imageProvider =
                Provider.of<ImageModel>(context, listen: false);
            return Dialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: 430,
                width: 750,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 40.0, left: 40, right: 40, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).editProfile,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        right: 40,
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Consumer<ImageModel>(
                                    builder: (context, model, child) {
                                  return model.pickedImage1 == null
                                      ? CircleAvatar(
                                          radius: 70,
                                          backgroundImage:
                                              AssetImage(defaultImage),
                                        )
                                      : CircleAvatar(
                                          radius: 70,
                                          backgroundImage:
                                              MemoryImage(model.webImage1),
                                        );
                                }),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: imageProvider.pickImage,
                                    child: const Icon(Icons.camera_alt),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 300,
                                  width: 500,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextField(
                                            text: S
                                                .of(context)
                                                .userName
                                                .toUpperCase(),
                                            hint: S.of(context).enterUserName,
                                            controller: userNameController,
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                            height: isArabic() ? 100 : 90,
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
                                            text: S
                                                .of(context)
                                                .email_Address
                                                .toUpperCase(),
                                            hint: S.of(context).enter_email,
                                            controller: emailController,
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                            height: isArabic() ? 100 : 90,
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
                                          const SizedBox(
                                            width: 100,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  imageProvider.emptyImage();
                                                },
                                                height: 40,
                                                width: 150,
                                                left: isArabic() ? 50 : 0,
                                                right: isArabic() ? 0 : 50,
                                                top: 5,
                                                bottom: 10,
                                                textSize: isArabic() ? 15 : 15,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background,
                                                textcolor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
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
                                                        setState(() {
                                                          isLoading = true;
                                                        });
                                                        final locale = Provider
                                                                .of<LocalizationProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                            .language!;
                                                        try {
                                                          dynamic response;
                                                          Uint8List? prImage;
                                                          if (imageProvider
                                                                  .pickedImage1 !=
                                                              null) {
                                                            prImage =
                                                                imageProvider
                                                                    .webImage1;
                                                          }

                                                          response = await ProfileServices()
                                                              .editProfileManagerService(
                                                                  prImage,
                                                                  userNameController
                                                                      .text,
                                                                  emailController
                                                                      .text,
                                                                  locale);

                                                          if (response.status ==
                                                              1) {
                                                            CustomSnackBar()
                                                                .showToast(
                                                                    response
                                                                        .message);
                                                          } else if (response
                                                                      .status ==
                                                                  0 &&
                                                              response.message !=
                                                                  null) {
                                                            String
                                                                errorMessage =
                                                                '';
                                                            if (response
                                                                .message!
                                                                .nameEn
                                                                .isNotEmpty) {
                                                              errorMessage +=
                                                                  response
                                                                      .message!
                                                                      .nameEn
                                                                      .first;
                                                            }
                                                            if (response
                                                                .message!
                                                                .nameAr
                                                                .isNotEmpty) {
                                                              errorMessage +=
                                                                  errorMessage
                                                                          .isNotEmpty
                                                                      ? ' and '
                                                                      : '';
                                                              errorMessage +=
                                                                  response
                                                                      .message!
                                                                      .nameAr
                                                                      .first;
                                                            }
                                                            CustomSnackBar()
                                                                .showToast(
                                                                    errorMessage);
                                                          } else {
                                                            CustomSnackBar()
                                                                .showToast(
                                                                    'Unknown error occurred');
                                                          }
                                                        } catch (e) {
                                                          CustomSnackBar()
                                                              .showToast(
                                                                  'Something went wrong: $e');
                                                          if (kDebugMode) {
                                                            print(e);
                                                          }
                                                        }
                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                        imageProvider
                                                            .setImage();
                                                        Navigator.pop(context);
                                                        imageProvider
                                                            .emptyImage();
                                                      },
                                                height: 40,
                                                width: 150,
                                                left: 0,
                                                right: 0,
                                                top: 5,
                                                bottom: 10,
                                                textSize: isArabic() ? 15 : 15,
                                                color: const Color.fromARGB(
                                                    255, 29, 104, 165),
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  void categoryDialog(BuildContext context,
      {required title, required text, required bool edit, required int id}) {
    final TextEditingController nameArController = TextEditingController();
    final TextEditingController nameEnController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    bool isLoading = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Form(
              key: formKey,
              child: Dialog(
                backgroundColor: Theme.of(context).colorScheme.background,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  height: isArabic() ? 450 : 430,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
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
                        Column(
                          children: [
                            CustomTextField(
                              text: S.of(context).categoryNameEn,
                              hint: S.of(context).entercategoryNameEn,
                              controller: nameEnController,
                              left: 0,
                              right: 0,
                              top: isArabic() ? 0 : 10,
                              bottom: 0,
                              height: isArabic() ? 110 : 100,
                              width: 500,
                              maxLines: false,
                              errorMsg: S.of(context).required,
                              fillColor: null,
                              prefix: null,
                              suffix: false,
                              obscure: false,
                              maxLength: null,
                              inputFormatter: null,
                            ),
                            CustomTextField(
                              text: S.of(context).categoryNameAr,
                              hint: S.of(context).entercategoryNameAr,
                              controller: nameArController,
                              left: 0,
                              right: 0,
                              top: isArabic() ? 0 : 10,
                              bottom: 0,
                              height: isArabic() ? 110 : 100,
                              width: 500,
                              maxLines: false,
                              errorMsg: S.of(context).required,
                              fillColor: null,
                              prefix: null,
                              suffix: false,
                              obscure: false,
                              maxLength: null,
                              inputFormatter: null,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                height: 40,
                                width: 140,
                                left: isArabic() ? 50 : 0,
                                right: isArabic() ? 0 : 50,
                                top: 5,
                                bottom: 10,
                                textSize: isArabic() ? 15 : 15,
                                color: Theme.of(context).colorScheme.background,
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
                                    : !edit
                                        ? () async {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            final locale = Provider.of<
                                                        LocalizationProvider>(
                                                    context,
                                                    listen: false)
                                                .language!;
                                            if (formKey.currentState!
                                                .validate()) {
                                              try {
                                                final response =
                                                    await CategoriesService()
                                                        .addCategoryService(
                                                            nameEnController
                                                                .text,
                                                            nameArController
                                                                .text,
                                                            locale);

                                                if (response.status == 1) {
                                                  Navigator.pop(context);
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
                                                  Navigator.pop(context);
                                                  CustomSnackBar()
                                                      .showToast(errorMessage);
                                                } else {
                                                  Navigator.pop(context);
                                                  CustomSnackBar().showToast(
                                                      'Unknown error occurred');
                                                }
                                              } catch (e) {
                                                Navigator.pop(context);
                                                if (kDebugMode) {
                                                  print(e);
                                                }
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              }
                                            }
                                          }
                                        : () async {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            dynamic response;
                                            final locale = Provider.of<
                                                        LocalizationProvider>(
                                                    context,
                                                    listen: false)
                                                .language!;
                                            try {
                                              if (nameEnController
                                                      .text.isNotEmpty &&
                                                  nameArController
                                                      .text.isNotEmpty) {
                                                response =
                                                    await CategoriesService()
                                                        .editCategoryService(
                                                            nameEnController
                                                                .text,
                                                            nameArController
                                                                .text,
                                                            id,
                                                            locale);
                                              } else if (nameEnController
                                                      .text.isEmpty &&
                                                  nameArController
                                                      .text.isNotEmpty) {
                                                response =
                                                    await CategoriesService()
                                                        .editCategoryService(
                                                            null,
                                                            nameArController
                                                                .text,
                                                            id,
                                                            locale);
                                              } else if (nameEnController
                                                      .text.isNotEmpty &&
                                                  nameArController
                                                      .text.isEmpty) {
                                                response =
                                                    await CategoriesService()
                                                        .editCategoryService(
                                                            nameEnController
                                                                .text,
                                                            null,
                                                            id,
                                                            locale);
                                              }

                                              if (response.status == 1) {
                                                Navigator.pop(context);
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
                                                Navigator.pop(context);
                                                CustomSnackBar()
                                                    .showToast(errorMessage);
                                              } else {
                                                Navigator.pop(context);
                                                CustomSnackBar().showToast(
                                                    'Unknown error occurred');
                                              }
                                            } catch (e) {
                                              Navigator.pop(context);
                                              if (kDebugMode) {
                                                print(e);
                                              }
                                              setState(() {
                                                isLoading = false;
                                              });
                                            }
                                          },
                                height: 40,
                                width: 140,
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
            );
          });
        });
  }

  void subCategoryDialog(BuildContext context,
      {required String text,
      required bool edit,
      required int categoryId,
      required int subcategoryId}) {
    final TextEditingController nameArController = TextEditingController();
    final TextEditingController nameEnController = TextEditingController();
    final imageProvider = Provider.of<ImageModel>(context, listen: false);
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    CategoryModel intialValue = allCategoriesList.first;
    CategoryModel categoryValue = intialValue;
    bool dropdownEdit = false;
    bool isLoading = false;
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
                  height: 500,
                  width: 850,
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
                            text,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    text: S.of(context).categoryNameEn,
                                    hint: S.of(context).entercategoryNameEn,
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
                                    maxLength: null,
                                    inputFormatter: null,
                                  ),
                                  CustomTextField(
                                    text: S.of(context).categoryNameAr,
                                    hint: S.of(context).entercategoryNameAr,
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
                                    maxLength: null,
                                    inputFormatter: null,
                                  ),
                                  edit
                                      ? Text(
                                          S.of(context).category,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          ),
                                        )
                                      : const SizedBox(),
                                  edit
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: SizedBox(
                                            width: 150,
                                            child:
                                                DropdownButton<CategoryModel>(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                    .withOpacity(0.5),
                                              ),
                                              iconSize: 36,
                                              isExpanded: true,
                                              value: categoryValue,
                                              onChanged:
                                                  (CategoryModel? value) {
                                                setState(() {
                                                  categoryValue = value!;
                                                  dropdownEdit = true;
                                                });
                                              },
                                              items: allCategoriesList.map<
                                                      DropdownMenuItem<
                                                          CategoryModel>>(
                                                  (CategoryModel item) {
                                                return DropdownMenuItem<
                                                    CategoryModel>(
                                                  value: item,
                                                  child: Text(
                                                    item.name,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onBackground),
                                                  ),
                                                );
                                              }).toList(),
                                              underline: const SizedBox(),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: edit ? 0 : 25, left: 100),
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Consumer<ImageModel>(
                                        builder: (context, model, child) {
                                      return model.pickedImage3 == null
                                          ? DottedBorder(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              child: Image.asset(
                                                'images/image.png',
                                                height: 220,
                                                width: 220,
                                              ),
                                            )
                                          : DottedBorder(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              child: Image.memory(
                                                model.webImage3,
                                                height: 220,
                                                width: 220,
                                              ),
                                            );
                                    }),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: imageProvider.pickImage2,
                                        child: const Icon(Icons.camera_alt),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: edit ? 15 : 35,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    imageProvider.emptyImage3();
                                  },
                                  height: 40,
                                  width: 150,
                                  left: isArabic() ? 50 : 0,
                                  right: isArabic() ? 0 : 50,
                                  top: 5,
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
                                          dynamic response;
                                          final locale =
                                              Provider.of<LocalizationProvider>(
                                                      context,
                                                      listen: false)
                                                  .language!;
                                          try {
                                            if (edit == true) {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              if (imageProvider.pickedImage3 !=
                                                  null) {
                                                if (dropdownEdit) {
                                                  response =
                                                      await SubcategoriesService()
                                                          .editSubcategoryService(
                                                              nameEnController
                                                                  .text,
                                                              nameArController
                                                                  .text,
                                                              imageProvider
                                                                  .webImage3,
                                                              categoryValue.id
                                                                  .toString(),
                                                              subcategoryId,
                                                              locale);
                                                } else {
                                                  response =
                                                      await SubcategoriesService()
                                                          .editSubcategoryService(
                                                              nameEnController
                                                                  .text,
                                                              nameArController
                                                                  .text,
                                                              imageProvider
                                                                  .webImage3,
                                                              null,
                                                              subcategoryId,
                                                              locale);
                                                }
                                              } else {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                if (dropdownEdit) {
                                                  response =
                                                      await SubcategoriesService()
                                                          .editSubcategoryService(
                                                              nameEnController
                                                                  .text,
                                                              nameArController
                                                                  .text,
                                                              null,
                                                              categoryValue.id
                                                                  .toString(),
                                                              subcategoryId,
                                                              locale);
                                                } else {
                                                  response =
                                                      await SubcategoriesService()
                                                          .editSubcategoryService(
                                                              nameEnController
                                                                  .text,
                                                              nameArController
                                                                  .text,
                                                              null,
                                                              null,
                                                              subcategoryId,
                                                              locale);
                                                }
                                              }
                                              setState(() {
                                                isLoading = false;
                                              });
                                              if (response.status == 1) {
                                                Navigator.pop(context);
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
                                                Navigator.pop(context);
                                                CustomSnackBar()
                                                    .showToast(errorMessage);
                                              } else {
                                                Navigator.pop(context);
                                                CustomSnackBar().showToast(
                                                    'Unknown error occurred');
                                              }
                                              setState(() {
                                                isLoading = false;
                                              });
                                            } else {
                                              if (key.currentState!
                                                  .validate()) {
                                                if (imageProvider
                                                        .pickedImage3 !=
                                                    null) {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  response =
                                                      await SubcategoriesService()
                                                          .addSubcategoryService(
                                                              nameEnController
                                                                  .text,
                                                              nameArController
                                                                  .text,
                                                              imageProvider
                                                                  .webImage3,
                                                              categoryId
                                                                  .toString(),
                                                              locale);
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                } else {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  response =
                                                      await SubcategoriesService()
                                                          .addSubcategoryService(
                                                              nameEnController
                                                                  .text,
                                                              nameArController
                                                                  .text,
                                                              null,
                                                              categoryId
                                                                  .toString(),
                                                              locale);
                                                }

                                                if (response.status == 1) {
                                                  Navigator.pop(context);
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
                                                  Navigator.pop(context);
                                                  CustomSnackBar()
                                                      .showToast(errorMessage);
                                                } else {
                                                  Navigator.pop(context);
                                                  CustomSnackBar().showToast(
                                                      'Unknown error occurred');
                                                }
                                              }
                                            }
                                          } catch (e) {
                                            Navigator.pop(context);
                                            if (kDebugMode) {
                                              print(e);
                                            }
                                          }
                                          setState(() {
                                            isLoading = false;
                                          });
                                          imageProvider.emptyImage3();
                                        },
                                  height: 40,
                                  width: 150,
                                  left: 0,
                                  right: 0,
                                  top: 5,
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
