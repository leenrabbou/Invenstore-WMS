// ignore_for_file: file_names, use_build_context_synchronously

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Address/CityModel.dart';
import 'package:buymore/Models/Address/StateModel.dart';
import 'package:buymore/Models/Manager/Distribution%20Center/CenterModel.dart';
import 'package:buymore/Models/Manager/Employee/AnEmployeeModel.dart';
import 'package:buymore/Models/Manager/Employee/EmployeeModel.dart';
import 'package:buymore/Models/Manager/ImageModel.dart';
import 'package:buymore/Models/Manager/Warehouse/WarehouseModel.dart';
import 'package:buymore/Models/Role/CustomRoleModel.dart';
import 'package:buymore/Models/Role/RoleModel.dart';
import 'package:buymore/Services/Address/AddressServices.dart';
import 'package:buymore/Services/Manager/EmployeesServices.dart';
import 'package:buymore/Services/Manager/RoleServices.dart';
import 'package:buymore/Services/Warehouse/WarehouseServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomSnackBar.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomTextField.dart';
import 'package:buymore/helper/Manager/ShowDialog/ShowDialog.dart';
import 'package:buymore/main.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class EmployeeShowDialog {
  void addEmployeeDialog(BuildContext context,
      {required String text,
      required bool edit,
      required EmployeeModel? employee}) {
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController ssnController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    bool male = false, female = false;
    bool editDate = false;
    bool warehouse = true, center = false;
    bool isLoading = false;
    CityModel cityIntialValue = allCitiesList.first;
    CityModel cityValue = cityIntialValue;
    bool isPressed = false, addAbility = false;
    StateModel? stateValue;
    RoleModel intialValue = warehouseRolesList.first;
    RoleModel roleValue = intialValue;
    List<RoleModel> rolesList = warehouseRolesList;
    WarehouseModel workplaceWarehouseValue = warehousesList.first;
    CenterModel workplaceCenterValue = centersList.first;
    DateTime currentDate = DateTime.now();
    bool warehouseValueEdit = false;
    bool centerValueEdit = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            final imageProvider =
                Provider.of<ImageModel>(context, listen: false);
            return Form(
              key: key,
              child: Dialog(
                backgroundColor: Theme.of(context).colorScheme.background,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  height: 700,
                  width: 850,
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
                              text,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
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
                                              text: S
                                                  .of(context)
                                                  .phoneNumber
                                                  .toUpperCase(),
                                              hint: S
                                                  .of(context)
                                                  .enterPhoneNumber,
                                              controller: phoneNumberController,
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
                                            CustomTextField(
                                              text: S
                                                  .of(context)
                                                  .password
                                                  .toUpperCase(),
                                              hint:
                                                  S.of(context).enter_password,
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
                                                        .secondary,
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
                                                        .secondary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
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
                                                    }),
                                                Text(
                                                  S.of(context).male,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
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
                                                        .secondary,
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
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2025),
                                                      builder:
                                                          (context, child) {
                                                        return Theme(
                                                          data: Theme.of(
                                                                  context)
                                                              .copyWith(
                                                                  colorScheme: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .copyWith(
                                                                        onSurface: Theme.of(context)
                                                                            .colorScheme
                                                                            .onBackground,
                                                                        background: Theme.of(context)
                                                                            .colorScheme
                                                                            .background,
                                                                      )),
                                                          child: child!,
                                                        );
                                                      },
                                                    );
                                                    if (pickedDate != null) {
                                                      setState(() {
                                                        currentDate =
                                                            pickedDate;
                                                        editDate = true;
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
                                                  '$currentDate'
                                                      .substring(0, 10),
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground,
                                                  ),
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
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 250,
                                                ),
                                                Text(
                                                  S.of(context).state,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
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
                                                    onChanged: (CityModel?
                                                        value) async {
                                                      setState(() {
                                                        cityValue = value!;
                                                        addAbility = true;
                                                      });
                                                      final locale = Provider
                                                              .of<LocalizationProvider>(
                                                                  context,
                                                                  listen: false)
                                                          .language!;
                                                      await AddressServices()
                                                          .allStatesForCityService(
                                                              cityValue.id,
                                                              locale);
                                                      statesForCityList
                                                              .isNotEmpty
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
                                                  width: 130,
                                                ),
                                                isPressed &&
                                                        statesForCityList
                                                            .isNotEmpty
                                                    ? SizedBox(
                                                        width: 140,
                                                        child: DropdownButton<
                                                            StateModel>(
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary
                                                                .withOpacity(
                                                                    0.5),
                                                          ),
                                                          iconSize: 36,
                                                          isExpanded: true,
                                                          value: stateValue,
                                                          onChanged:
                                                              (StateModel?
                                                                  value) {
                                                            setState(() {
                                                              stateValue =
                                                                  value!;
                                                            });
                                                          },
                                                          items: statesForCityList.map<
                                                                  DropdownMenuItem<
                                                                      StateModel>>(
                                                              (StateModel
                                                                  item) {
                                                            return DropdownMenuItem<
                                                                StateModel>(
                                                              value: item,
                                                              child: Text(
                                                                item.name,
                                                                style:
                                                                    TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .onBackground,
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          underline:
                                                              const SizedBox(
                                                            width: 140,
                                                          ),
                                                        ),
                                                      )
                                                    : Text(
                                                        S().noAvalibaleStates,
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onBackground,
                                                        ),
                                                      ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                addAbility
                                                    ? IconButton(
                                                        onPressed: () {
                                                          ShowDialog()
                                                              .addStateDialog(
                                                            context,
                                                            city: cityValue,
                                                          );
                                                        },
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                            const Color
                                                                .fromARGB(175,
                                                                126, 150, 170),
                                                          ),
                                                          iconColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .white),
                                                        ),
                                                        icon: const Icon(
                                                            Icons.add),
                                                      )
                                                    // ? CustomElevatedButton(
                                                    //     onPressed: () {
                                                    //       addStateDialog(
                                                    //         context,
                                                    //         city: cityValue,
                                                    //       );
                                                    //     },
                                                    //     text: '+ ',
                                                    //     height: 25,
                                                    //     width: 30,
                                                    //     left: 0,
                                                    //     right: 0,
                                                    //     top: 0,
                                                    //     bottom: 0,
                                                    //     textSize: 15,
                                                    //     color:
                                                    //         const Color.fromARGB(
                                                    //             175,
                                                    //             126,
                                                    //             150,
                                                    //             170),
                                                    //     elevation: 5,
                                                    //     textcolor: Colors.white,
                                                    //   )
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
                                                Checkbox(
                                                    value: warehouse,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        if (center == true) {
                                                          center = false;

                                                          roleValue =
                                                              warehouseRolesList
                                                                  .first;
                                                          rolesList =
                                                              warehouseRolesList;
                                                        }
                                                        warehouse = value!;
                                                      });
                                                    }),
                                                Text(
                                                  S.of(context).warehouse,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 40,
                                                ),
                                                Checkbox(
                                                    value: center,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        if (warehouse == true) {
                                                          warehouse = false;

                                                          roleValue =
                                                              centersRolesList
                                                                  .first;
                                                          rolesList =
                                                              centersRolesList;
                                                        }
                                                        center = value!;
                                                      });
                                                    }),
                                                Text(
                                                  S
                                                      .of(context)
                                                      .distributionCenter,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 270,
                                                  child: Text(
                                                    S.of(context).role,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  S.of(context).workplace,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: SizedBox(
                                                    width: 180,
                                                    child: DropdownButton<
                                                        RoleModel>(
                                                      icon: Icon(
                                                        Icons.arrow_drop_down,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary
                                                            .withOpacity(0.5),
                                                      ),
                                                      iconSize: 36,
                                                      isExpanded: true,
                                                      value: roleValue,
                                                      onChanged:
                                                          (RoleModel? value) {
                                                        setState(() {
                                                          roleValue = value!;
                                                        });
                                                      },
                                                      items: rolesList.map<
                                                              DropdownMenuItem<
                                                                  RoleModel>>(
                                                          (RoleModel item) {
                                                        return DropdownMenuItem<
                                                            RoleModel>(
                                                          value: item,
                                                          child: Text(
                                                            item.name,
                                                            style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onBackground,
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      underline:
                                                          const SizedBox(),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 80,
                                                ),

                                                warehouse
                                                    ? SizedBox(
                                                        width: 180,
                                                        child: DropdownButton<
                                                            WarehouseModel>(
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary
                                                                .withOpacity(
                                                                    0.5),
                                                          ),
                                                          iconSize: 36,
                                                          isExpanded: true,
                                                          value:
                                                              workplaceWarehouseValue,
                                                          onChanged:
                                                              (WarehouseModel?
                                                                  value) {
                                                            setState(() {
                                                              workplaceWarehouseValue =
                                                                  value!;
                                                              warehouseValueEdit =
                                                                  true;
                                                            });
                                                          },
                                                          items: warehousesList.map<
                                                                  DropdownMenuItem<
                                                                      WarehouseModel>>(
                                                              (WarehouseModel
                                                                  item) {
                                                            return DropdownMenuItem<
                                                                WarehouseModel>(
                                                              value: item,
                                                              child: Text(
                                                                item.name,
                                                                style:
                                                                    TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .onBackground,
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          underline:
                                                              const SizedBox(),
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        width: 180,
                                                        child: DropdownButton<
                                                            CenterModel>(
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary
                                                                .withOpacity(
                                                                    0.5),
                                                          ),
                                                          iconSize: 36,
                                                          isExpanded: true,
                                                          value:
                                                              workplaceCenterValue,
                                                          onChanged:
                                                              (CenterModel?
                                                                  value) {
                                                            setState(() {
                                                              workplaceCenterValue =
                                                                  value!;
                                                              centerValueEdit =
                                                                  true;
                                                            });
                                                          },
                                                          items: centersList.map<
                                                                  DropdownMenuItem<
                                                                      CenterModel>>(
                                                              (CenterModel
                                                                  item) {
                                                            return DropdownMenuItem<
                                                                CenterModel>(
                                                              value: item,
                                                              child: Text(
                                                                item.name,
                                                              ),
                                                            );
                                                          }).toList(),
                                                          underline:
                                                              const SizedBox(),
                                                        ),
                                                      ),
                                                // DropdownButton(
                                                //     underline: const SizedBox(),
                                                //     value: workplaceWarehouseValue,
                                                //     items: const [
                                                //       DropdownMenuItem(
                                                //         value: 1,
                                                //         child: Text(
                                                //           'Phenix',
                                                //           style: TextStyle(
                                                //               fontSize: 15),
                                                //         ),
                                                //       ),
                                                //       DropdownMenuItem(
                                                //         value: 2,
                                                //         child: Text(
                                                //           'Arabic',
                                                //           style: TextStyle(
                                                //               fontSize: 15),
                                                //         ),
                                                //       ),
                                                //     ],
                                                //     onChanged: (value) {
                                                //       setState(() {
                                                //         workplaceWarehouseValue = value;
                                                //       });
                                                //     }),
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                  textSize:
                                                      isArabic() ? 15 : 15,
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
                                                      // color: Colors.white,
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
                                                                      listen:
                                                                          false)
                                                                  .language!;
                                                          if (kDebugMode) {
                                                            print(
                                                                roleValue.name);
                                                          }
                                                          if (kDebugMode) {
                                                            print(roleValue.id);
                                                          }
                                                          dynamic response;
                                                          String gender =
                                                                  'male',
                                                              employeableType =
                                                                  'Warehouse';

                                                          if (female) {
                                                            gender = 'female';
                                                          }
                                                          if (center) {
                                                            employeableType =
                                                                'DistributionCenter';
                                                          }

                                                          setState(() {
                                                            isLoading = true;
                                                          });

                                                          if (!edit) {
                                                            String employeable =
                                                                workplaceWarehouseValue
                                                                    .name;
                                                            int employeableId =
                                                                workplaceWarehouseValue
                                                                    .id;
                                                            if (center) {
                                                              employeable =
                                                                  workplaceCenterValue
                                                                      .name;
                                                              employeableId =
                                                                  workplaceCenterValue
                                                                      .id;
                                                            }
                                                            // else if(warehouse)
                                                            // {

                                                            //   employeableId
                                                            // }
                                                            if (key
                                                                .currentState!
                                                                .validate()) {
                                                              try {
                                                                if (imageProvider
                                                                        .pickedImage3 !=
                                                                    null) {
                                                                  response = await EmployeesServices().addEmployeeService(
                                                                      imageProvider
                                                                          .webImage3,
                                                                      addressController
                                                                          .text,
                                                                      userNameController
                                                                          .text,
                                                                      fullNameController
                                                                          .text,
                                                                      emailController
                                                                          .text,
                                                                      passwordController
                                                                          .text,
                                                                      gender,
                                                                      currentDate
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              10),
                                                                      phoneNumberController
                                                                          .text,
                                                                      ssnController
                                                                          .text,
                                                                      employeableType,
                                                                      employeable,
                                                                      stateValue!
                                                                          .id,
                                                                      roleValue
                                                                          .id,
                                                                      employeableId,
                                                                      locale);
                                                                } else {
                                                                  response = await EmployeesServices().addEmployeeService(
                                                                      null,
                                                                      addressController
                                                                          .text,
                                                                      userNameController
                                                                          .text,
                                                                      fullNameController
                                                                          .text,
                                                                      emailController
                                                                          .text,
                                                                      passwordController
                                                                          .text,
                                                                      gender,
                                                                      currentDate
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              10),
                                                                      phoneNumberController
                                                                          .text,
                                                                      ssnController
                                                                          .text,
                                                                      employeableType,
                                                                      employeable,
                                                                      stateValue!
                                                                          .id,
                                                                      roleValue
                                                                          .id,
                                                                      employeableId,
                                                                      locale);
                                                                }
                                                                if (response
                                                                        .status ==
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
                                                                    errorMessage += response
                                                                        .message!
                                                                        .nameEn
                                                                        .first;
                                                                  }
                                                                  if (response
                                                                      .message!
                                                                      .nameAr
                                                                      .isNotEmpty) {
                                                                    errorMessage +=
                                                                        errorMessage.isNotEmpty
                                                                            ? ' and '
                                                                            : '';
                                                                    errorMessage += response
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
                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                          } else if (edit) {
                                                            String? employeable;
                                                            int? employeableId;
                                                            if (male == false &&
                                                                female ==
                                                                    false) {
                                                              gender = employee!
                                                                  .gender;
                                                            }
                                                            int? stateId;
                                                            if (stateValue !=
                                                                null) {
                                                              stateId =
                                                                  stateValue!
                                                                      .id;
                                                            }
                                                            String? newDate;
                                                            if (editDate) {
                                                              newDate =
                                                                  currentDate
                                                                      .toString()
                                                                      .substring(
                                                                          0,
                                                                          10);
                                                            }
                                                            if (warehouseValueEdit &&
                                                                warehouse) {
                                                              employeable =
                                                                  workplaceWarehouseValue
                                                                      .name;
                                                              employeableId =
                                                                  workplaceWarehouseValue
                                                                      .id;
                                                            }
                                                            if (centerValueEdit &&
                                                                center) {
                                                              employeable =
                                                                  workplaceCenterValue
                                                                      .name;
                                                              employeableId =
                                                                  workplaceCenterValue
                                                                      .id;
                                                            }
                                                            try {
                                                              if (imageProvider
                                                                      .pickedImage3 !=
                                                                  null) {
                                                                response = await EmployeesServices().editEmployeeService(
                                                                    employee!
                                                                        .id,
                                                                    imageProvider
                                                                        .webImage3,
                                                                    addressController
                                                                        .text,
                                                                    userNameController
                                                                        .text,
                                                                    fullNameController
                                                                        .text,
                                                                    emailController
                                                                        .text,
                                                                    passwordController
                                                                        .text,
                                                                    gender,
                                                                    newDate,
                                                                    phoneNumberController
                                                                        .text,
                                                                    ssnController
                                                                        .text,
                                                                    employeableType,
                                                                    employeable,
                                                                    stateId,
                                                                    roleValue
                                                                        .id,
                                                                    employeableId,
                                                                    locale);
                                                              } else {
                                                                response = await EmployeesServices().editEmployeeService(
                                                                    employee!
                                                                        .id,
                                                                    null,
                                                                    addressController
                                                                        .text,
                                                                    userNameController
                                                                        .text,
                                                                    fullNameController
                                                                        .text,
                                                                    emailController
                                                                        .text,
                                                                    passwordController
                                                                        .text,
                                                                    gender,
                                                                    newDate,
                                                                    phoneNumberController
                                                                        .text,
                                                                    ssnController
                                                                        .text,
                                                                    employeableType,
                                                                    employeable,
                                                                    stateId,
                                                                    roleValue
                                                                        .id,
                                                                    employeableId,
                                                                    locale);
                                                              }
                                                              if (response
                                                                      .status ==
                                                                  1) {
                                                                CustomSnackBar()
                                                                    .showToast(
                                                                        response
                                                                            .message);
                                                              } else if (response
                                                                      .status ==
                                                                  0) {
                                                                CustomSnackBar()
                                                                    .showToast(
                                                                        response
                                                                            .message);
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
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                          imageProvider
                                                              .emptyImage3();
                                                        },
                                                  height: 40,
                                                  width: 150,
                                                  left: 0,
                                                  right: 0,
                                                  top: 5,
                                                  bottom: 10,
                                                  textSize:
                                                      isArabic() ? 15 : 15,
                                                  color: const Color.fromARGB(
                                                      255, 29, 104, 165),
                                                  elevation: 5,
                                                  textcolor: Colors.white,
                                                  child: isLoading
                                                      ? SpinKitThreeInOut(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .background,
                                                          size: 20,
                                                        )
                                                      : Text(
                                                          S.of(context).save,
                                                          style:
                                                              const TextStyle(
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
              ),
            );
          });
        });
  }

  void addRole(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    List<CustomRoleModel> items = [
      CustomRoleModel(
        name: 'Show Categories',
        value: 'category.index',
        checked: false,
      ),
      CustomRoleModel(
        name: S().addCategory,
        value: 'category.store',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Update Categories',
        value: 'category.update',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Delete Categories',
        value: 'category.destroy',
        checked: false,
      ),

      CustomRoleModel(
        name: 'Show Warehouses',
        value: 'warehouse.index',
        checked: false,
      ),
//CustomRoleModel(name: 'Show Warehouses', value: 'warehouse.show', checked: false,),
      CustomRoleModel(
        name: 'Add Warehouses',
        value: 'warehouse.store',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Update Warehouses',
        value: 'warehouse.update',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Show Warehouse Centers',
        value: 'warehouse.show.centers',
        checked: false,
      ), //!

      CustomRoleModel(
        name: 'Show Distribution Centers',
        value: 'distributionCenter.index',
        checked: false,
      ),
//CustomRoleModel(name: 'Show Distribution Centers', value: 'distributionCenter.show', checked: false,),
      CustomRoleModel(
        name: 'Add Distribution Centers',
        value: 'distributionCenter.store',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Update Distribution Centers',
        value: 'distributionCenter.update',
        checked: false,
      ),

      CustomRoleModel(
        name: 'Show Products',
        value: 'product.index',
        checked: false,
      ),
//CustomRoleModel(name: 'Show Products', value: 'product.show', checked: false,),
      CustomRoleModel(
        name: 'Add Products',
        value: 'product.store',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Update Products',
        value: 'product.update',
        checked: false,
      ),

      CustomRoleModel(
        name: 'Show Manufacturers',
        value: 'manufacturer.index',
        checked: false,
      ),
//CustomRoleModel(name: 'Show Manufacturers', value: 'manufacturer.show', checked: false,),
      CustomRoleModel(
        name: 'Add Manufacturers',
        value: 'manufacturer.store',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Update Manufacturers',
        value: 'manufacturer.update',
        checked: false,
      ),

      CustomRoleModel(
        name: 'Show Own Warehouses',
        value: 'warehouse.own.show',
        checked: false,
      ),

      CustomRoleModel(
        name: 'Show Centers',
        value: 'center.index',
        checked: false,
      ),
//CustomRoleModel(name: 'Show Centers', value: 'center.show', checked: false,),
      CustomRoleModel(
        name: 'Add Centers',
        value: 'center.store',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Update Centers',
        value: 'center.update',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Show Own Centers',
        value: 'center.own.show',
        checked: false,
      ),

      CustomRoleModel(
        name: 'Update Product Minimum',
        value: 'product.min.update',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Update Stored Products',
        value: 'product.stored.update',
        checked: false,
      ),

      CustomRoleModel(
        name: 'Show Employees',
        value: 'employee.index',
        checked: false,
      ),
//CustomRoleModel(name: 'Show Employees', value: 'employee.show', checked: false,),
      CustomRoleModel(
        name: 'Add Employees',
        value: 'employee.store',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Update Employees',
        value: 'employee.update',
        checked: false,
      ),

      CustomRoleModel(
        name: 'Show Orders',
        value: 'orders.index',
        checked: false,
      ),
//CustomRoleModel(name: 'Show Orders', value: 'orders.show', checked: false,),
      CustomRoleModel(
        name: 'Add Buy Orders',
        value: 'orders.buy.store',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Add Manufacturer Orders',
        value: 'orders.manufacturer.store',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Update Sell Orders',
        value: 'orders.sell.update',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Update Buy Orders',
        value: 'orders.buy.update',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Update Own Orders',
        value: 'orders.own.update',
        checked: false,
      ),

      CustomRoleModel(
        name: 'Show Shipping Companies',
        value: 'shippingCompany.index',
        checked: false,
      ),
//CustomRoleModel(name: 'Show Shipping Companies', value: 'shippingCompany.show', checked: false,),
      CustomRoleModel(
        name: 'Add Shipping Companies',
        value: 'shippingCompany.store',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Update Shipping Companies',
        value: 'shippingCompany.update',
        checked: false,
      ),

      CustomRoleModel(
        name: 'Show Shipments',
        value: 'shipment.index',
        checked: false,
      ),
//CustomRoleModel(name: 'Show Shipments', value: 'shipment.show', checked: false,),
      CustomRoleModel(
        name: 'Add Shipments',
        value: 'shipment.store',
        checked: false,
      ),

      CustomRoleModel(
        name: 'Show Roles',
        value: 'role.index',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Add Roles',
        value: 'role.store',
        checked: false,
      ),

      CustomRoleModel(
        name: 'Show Destructions',
        value: 'destruction.index',
        checked: false,
      ),
//CustomRoleModel(name: 'Show Destructions', value: 'destruction.show', checked: false,),
      CustomRoleModel(
        name: 'Add Destructions',
        value: 'destruction.store',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Continue Manager',
        value: 'manager.continue',
        checked: false,
      ),

      CustomRoleModel(
        name: 'Show Sales',
        value: 'sale.index',
        checked: false,
      ),
//CustomRoleModel(name: 'Show Sales', value: 'sale.show', checked: false,),
      CustomRoleModel(
        name: 'Add Sales',
        value: 'sale.store',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Show Reports',
        value: 'report.show',
        checked: false,
      ),
      CustomRoleModel(
        name: 'Ban Employees',
        value: 'employee.ban',
        checked: false,
      ),
      CustomRoleModel(
        name: 'get notifications for expired products',
        value: 'product.expired.notify',
        checked: false,
      ),
      CustomRoleModel(
        name: 'get notifications for quantity of products',
        value: 'product.warning.notify',
        checked: false,
      ),
    ];
    List<String> per = [];
    List<String> type = ['Warehouse', 'destribution center'];
    String intialValue = type.first;
    String value = intialValue;
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
                  height: 700,
                  width: 1000,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add role',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
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
                          Row(
                            children: [
                              CustomTextField(
                                text: '',
                                hint: 'enter role name',
                                controller: nameController,
                                left: 0,
                                right: 0,
                                top: 0,
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
                              const SizedBox(
                                width: 30,
                              ),
                              SizedBox(
                                width: 200,
                                child: DropdownButton<String>(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.5),
                                  ),
                                  iconSize: 36,
                                  isExpanded: true,
                                  value: value,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      value = newValue!;
                                    });
                                  },
                                  items: type.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
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
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  for (var item in items) {
                                    item.checked = true;
                                  }
                                  setState(() {});
                                },
                                child: const Text('Select All'),
                              ),
                              TextButton(
                                onPressed: () {
                                  for (var item in items) {
                                    item.checked = false;
                                  }
                                  //per.clear();
                                  setState(() {});
                                },
                                child: const Text('Unselect All'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 620,
                            width: 750,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 6,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                    ),
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: CheckboxListTile(
                                          title: Text(
                                            items[index].name,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                            ),
                                          ),
                                          value: items[index].checked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              items[index].checked = value!;
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
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
                                color: Theme.of(context).colorScheme.background,
                                textcolor:
                                    Theme.of(context).colorScheme.secondary,
                                elevation: 0,
                                child: Text(
                                  S.of(context).cancel,
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
                                        for (var item in items) {
                                          item.checked
                                              ? per.add(item.value)
                                              : null;
                                        }
                                        final locale =
                                            Provider.of<LocalizationProvider>(
                                                    context,
                                                    listen: false)
                                                .language!;
                                        if (key.currentState!.validate()) {
                                          if (per.isNotEmpty) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            dynamic response =
                                                await RolesServices()
                                                    .addRoleService(
                                                        nameController.text,
                                                        value,
                                                        per,
                                                        locale);

                                            CustomSnackBar()
                                                .showToast(response.message);
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Navigator.pop(context);
                                          }
                                        }
                                        per.clear();
                                      },
                                height: 40,
                                width: 150,
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

  void banEmployee(BuildContext context, {required EmployeeModel employee}) {
    DateTime currentDate = DateTime.now();
    bool editDate = false;
    bool isLoading = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: 300,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ban Employee',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ban Expired At',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            Row(
                              children: [
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
                                              colorScheme: Theme.of(context)
                                                  .colorScheme
                                                  .copyWith(
                                                    onSurface: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground,
                                                    background:
                                                        Theme.of(context)
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
                                        editDate = true;
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
                                        .onBackground,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
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
                                  : () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      try {
                                        String? newDate;
                                        editDate
                                            ? newDate = currentDate
                                                .toString()
                                                .substring(0, 10)
                                            : null;
                                        final locale =
                                            Provider.of<LocalizationProvider>(
                                                    context,
                                                    listen: false)
                                                .language!;

                                        AnEmployeeModel response =
                                            await EmployeesServices()
                                                .banEmployeesService(
                                                    employee.id,
                                                    newDate,
                                                    locale);
                                        CustomSnackBar()
                                            .showToast(response.message);
                                      } catch (e) {}

                                      setState(() {
                                        isLoading = false;
                                      });

                                      Navigator.pop(context);
                                    },
                              height: 40,
                              width: 150,
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
                                      S.of(context).confirm,
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
            );
          });
        });
  }

  void unbanEmployee(BuildContext context, {required EmployeeModel employee}) {
    bool isLoading = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              content: Padding(
                padding: const EdgeInsets.all(30),
                child: Text(
                  'you  will unban this employee. are you sure?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  maxLines: 2,
                ),
              ),
              actions: [
                CustomElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  height: 40,
                  width: 100,
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
                          try {
                            final locale = Provider.of<LocalizationProvider>(
                                    context,
                                    listen: false)
                                .language!;

                            AnEmployeeModel response = await EmployeesServices()
                                .unbanEmployeesService(employee.id, locale);
                            setState(() {
                              isLoading = false;
                            });
                            CustomSnackBar().showToast(response.message);
                            Navigator.pop(context);
                          } catch (e) {}
                        },
                  height: 40,
                  width: 100,
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
                          color: Theme.of(context).colorScheme.background,
                          size: 20,
                        )
                      : Text(
                          S.of(context).yes,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            );
          });
        });
  }
}
