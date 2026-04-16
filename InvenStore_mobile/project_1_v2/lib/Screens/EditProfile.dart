// ignore_for_file: file_names, use_build_context_synchronously

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Address/CityModel.dart';
import 'package:project_1_v2/Models/Address/StateModel.dart';
import 'package:project_1_v2/Models/Manager/ImageModel.dart';
import 'package:project_1_v2/Services/Address/AddressServices.dart';
import 'package:project_1_v2/Services/Warehouse/ProfileService.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/Constant.dart';
import 'package:project_1_v2/helper/CustomElevatedButton.dart';
import 'package:project_1_v2/helper/CustomSnackBar.dart';
import 'package:project_1_v2/helper/CustomTextField.dart';
import 'package:project_1_v2/helper/ShowDialog.dart';
import 'package:project_1_v2/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController ssnController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool male = false, female = false;
  CityModel intialValue = allCitiesList.first;
  CityModel cityValue = allCitiesList.first;
  bool dropdownStateEdit = false;
  DateTime currentDate = DateTime.now();
  bool editdate = false;
  bool isPressed = false, addAbility = false;
  StateModel? stateValue;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageModel>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          S().editProfile,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Consumer<ImageModel>(
                      builder: (context, model, child) {
                        return model.pickedImage1 == null
                            ? CircleAvatar(
                                radius: 70,
                                backgroundImage: AssetImage(defaultImage),
                              )
                            : CircleAvatar(
                                radius: 70,
                                backgroundImage: FileImage(model.pickedImage1!),
                              );
                      },
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: imageProvider.pickImage,
                        child: const Icon(Icons.camera_alt),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                text: S.of(context).fullName.toUpperCase(),
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
                text: S.of(context).userName.toUpperCase(),
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
                text: S.of(context).email_Address.toUpperCase(),
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
                text: S.of(context).phoneNumber.toUpperCase(),
                hint: S.of(context).enterPhoneNumber,
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
                text: S.of(context).password.toUpperCase(),
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
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 180),
                  Text(
                    S.of(context).birthDay,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Checkbox(
                    value: male,
                    onChanged: (value) {
                      setState(() {
                        if (female == true) {
                          female = false;
                        }
                        male = value!;
                      });
                    },
                  ),
                  Text(
                    S.of(context).male,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Checkbox(
                    value: female,
                    onChanged: (value) {
                      setState(() {
                        if (male == true) {
                          male = false;
                        }
                        female = value!;
                      });
                    },
                  ),
                  Text(
                    S.of(context).female,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 45),
                  IconButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2025),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: Theme.of(context).colorScheme
                                  .copyWith(
                                    onSurface: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    background: Theme.of(
                                      context,
                                    ).colorScheme.background,
                                  ),
                            ),
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
                    icon: const Icon(Icons.calendar_month),
                  ),
                  Text('$currentDate'.substring(0, 10)),
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
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 150),
                  Text(
                    S.of(context).state,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: DropdownButton<CityModel>(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withOpacity(0.5),
                      ),
                      iconSize: 36,
                      isExpanded: true,
                      value: cityValue,
                      onChanged: (CityModel? value) async {
                        setState(() {
                          cityValue = value!;
                          addAbility = true;
                        });
                        final locale = Provider.of<LocalizationProvider>(
                          context,
                          listen: false,
                        ).language!;
                        await AddressServices().allStatesForCityService(
                          cityValue.id,
                          locale,
                        );
                        statesForCityList.isNotEmpty
                            ? setState(() {
                                stateValue = statesForCityList.first;
                                isPressed = true;
                              })
                            : setState(() {
                                isPressed = false;
                              });
                      },
                      items: allCitiesList.map<DropdownMenuItem<CityModel>>((
                        CityModel item,
                      ) {
                        return DropdownMenuItem<CityModel>(
                          value: item,
                          child: Text(item.name),
                        );
                      }).toList(),
                      underline: const SizedBox(width: 100),
                    ),
                  ),
                  const SizedBox(width: 50),
                  isPressed && statesForCityList.isNotEmpty
                      ? SizedBox(
                          width: 100,
                          child: DropdownButton<StateModel>(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Theme.of(
                                context,
                              ).colorScheme.secondary.withOpacity(0.5),
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
                                .map<DropdownMenuItem<StateModel>>((
                                  StateModel item,
                                ) {
                                  return DropdownMenuItem<StateModel>(
                                    value: item,
                                    child: Text(item.name),
                                  );
                                })
                                .toList(),
                            underline: const SizedBox(width: 100),
                          ),
                        )
                      : Text(S().noAvalibaleStates),
                  const SizedBox(width: 10),
                  addAbility
                      ? IconButton(
                          onPressed: () {
                            ShowDialog().addStateDialog(
                              context,
                              city: cityValue,
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(175, 126, 150, 170),
                            ),
                            iconColor: MaterialStateProperty.all(Colors.white),
                          ),
                          icon: const Icon(Icons.add),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              CustomTextField(
                text: S.of(context).address.toUpperCase(),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        imageProvider.emptyImage();
                      },
                      height: 40,
                      width: 120,
                      left: isArabic() ? 50 : 0,
                      right: isArabic() ? 0 : 50,
                      top: 5,
                      bottom: 10,
                      textSize: isArabic() ? 15 : 15,
                      color: Theme.of(context).colorScheme.background,
                      textcolor: Theme.of(context).colorScheme.secondary,
                      elevation: 0,
                      child: Text(
                        S.of(context).cancel,
                        style: const TextStyle(
                          fontSize: 15,
                          //  color: Colors.white,
                        ),
                      ),
                    ),
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
                              try {
                                dynamic response;
                                Uint8List? prImage;
                                String? gender;
                                String? newDate;
                                int? newStateValue;
                                if (imageProvider.pickedImage1 != null) {
                                  prImage = await imageProvider.pickedImage1!
                                      .readAsBytes();
                                }

                                if (female) {
                                  gender = 'female';
                                } else if (male) {
                                  gender = 'male';
                                }
                                if (editdate) {
                                  newDate = currentDate.toString().substring(
                                    0,
                                    10,
                                  );
                                }

                                dropdownStateEdit
                                    ? newStateValue = stateValue!.id
                                    : null;
                                response = await ProfileServices()
                                    .editProfileWarehouseService(
                                      prImage,
                                      addressController.text,
                                      userNameController.text,
                                      fullNameController.text,
                                      emailController.text,
                                      gender,
                                      newDate,
                                      phoneNumberController.text,
                                      newStateValue,
                                      locale,
                                    );

                                if (response.status == 1) {
                                  CustomSnackBar().showToast(response.message);
                                } else if (response.status == 0 &&
                                    response.message != null) {
                                  String errorMessage = '';
                                  if (response.message!.nameEn.isNotEmpty) {
                                    errorMessage +=
                                        response.message!.nameEn.first;
                                  }
                                  if (response.message!.nameAr.isNotEmpty) {
                                    errorMessage += errorMessage.isNotEmpty
                                        ? ' ${S().and} '
                                        : '';
                                    errorMessage +=
                                        response.message!.nameAr.first;
                                  }
                                  CustomSnackBar().showToast(errorMessage);
                                } else {
                                  CustomSnackBar().showToast(
                                    S().unknownErrorOccurred,
                                  );
                                }
                              } catch (e) {
                                CustomSnackBar().showToast('$e');
                                if (kDebugMode) {
                                  print(e);
                                }
                              }
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pop(context);
                              imageProvider.emptyImage();
                            },
                      height: 40,
                      width: 120,
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
                              color: Theme.of(context).colorScheme.background,
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
    );
  }
}
