// ignore_for_file: file_names, must_be_immutable

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Manager/Employee/EmployeeModel.dart';
import 'package:buymore/Services/Manager/EmployeesServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/DetailsContainer.dart';
import 'package:buymore/helper/Manager/Employee/EmployeeShowDialog.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  EmployeeDetailsScreen({super.key, required this.employee});
  EmployeeModel employee;

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  late String defaultImage;

  Future<void> _onRefresh() async {
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    await Future.delayed(
      const Duration(seconds: 2),
    );
    try {
      final newData = await EmployeesServices()
          .showAnEmployeeService(widget.employee.id, locale);
      setState(() {
        widget.employee = newData.data;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.employee.gender == 'male') {
      defaultImage = 'images/male3.jpg';
    } else if (widget.employee.gender == 'female') {
      defaultImage = 'images/female2.jpg';
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          S.of(context).employeeDetails,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        actions: [
          permissionsMap['employee.update'] == true
              ? Padding(
                  padding: EdgeInsets.only(
                      top: 10.0,
                      right: isArabic() ? 0 : 30,
                      left: isArabic() ? 30 : 0),
                  child: TextButton(
                    onPressed: () {
                      EmployeeShowDialog().addEmployeeDialog(context,
                          text: S.of(context).editEmployee,
                          edit: true,
                          employee: widget.employee);
                    },
                    child: Text(
                      S.of(context).editEmployee,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 15),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          widget.employee.isBanned! && permissionsMap['employee.ban'] == true
              ? Padding(
                  padding: EdgeInsets.only(
                      top: 10.0,
                      right: isArabic() ? 0 : 30,
                      left: isArabic() ? 30 : 0),
                  child: TextButton(
                    onPressed: () {
                      EmployeeShowDialog()
                          .unbanEmployee(context, employee: widget.employee);
                    },
                    child: const Text(
                      'Unban Employee',
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                )
              : permissionsMap['employee.ban'] == true
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: 10.0,
                          right: isArabic() ? 0 : 30,
                          left: isArabic() ? 30 : 0),
                      child: TextButton(
                        onPressed: () {
                          EmployeeShowDialog()
                              .banEmployee(context, employee: widget.employee);
                        },
                        child: const Text(
                          'Ban Employee',
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
        ],
      ),
      body: LiquidPullToRefresh(
        onRefresh: _onRefresh,
        color: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.primary,
        height: 100,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 450,
              width: 270,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ],
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  )),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        S.of(context).profileImage,
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.5),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: widget.employee.image == null
                          ? Image.asset(
                              defaultImage,
                              height: 220,
                              width: 220,
                              fit: BoxFit.fill,
                            )
                          : Image.network(
                              '$imageUrl/${widget.employee.image!}',
                              height: 220,
                              width: 220,
                              fit: BoxFit.fill,
                            ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 20),
                      child: Divider(
                        thickness: 0.5,
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(0.2),
                      ),
                    ),
                    DetailsContainer(
                      title: S.of(context).role,
                      text: widget.employee.role,
                      height: 50,
                      width: 250,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DetailsContainer(
                      title: S.of(context).workplace.toUpperCase(),
                      text: widget.employee.employable,
                      height: 50,
                      width: 250,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 800,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 400,
                      width: 700,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          )
                        ],
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: FittedBox(
                                child: Text(
                                  S.of(context).personalData,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DetailsContainer(
                              title: S.of(context).fullName.toUpperCase(),
                              text: widget.employee.fullName,
                              height: 50,
                              width: 670,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                DetailsContainer(
                                  title: S.of(context).birthDay,
                                  text: widget.employee.birthDate,
                                  height: 50,
                                  width: 330,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                DetailsContainer(
                                  title: S.of(context).gender,
                                  text: widget.employee.gender,
                                  height: 50,
                                  width: 330,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            DetailsContainer(
                              title: S.of(context).ssn,
                              text: widget.employee.ssn,
                              height: 50,
                              width: 670,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                DetailsContainer(
                                  title: S.of(context).city.toUpperCase(),
                                  text: widget.employee.city,
                                  height: 50,
                                  width: 330,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                DetailsContainer(
                                  title: S.of(context).state.toUpperCase(),
                                  text: widget.employee.state,
                                  height: 50,
                                  width: 330,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            DetailsContainer(
                              title: S.of(context).address.toUpperCase(),
                              text: widget.employee.address == null
                                  ? '--'
                                  : widget.employee.address!,
                              height: 50,
                              width: 670,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 270,
                      width: 700,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          )
                        ],
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: FittedBox(
                                child: Text(
                                  S.of(context).contactInfo,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DetailsContainer(
                              title: S.of(context).userName.toUpperCase(),
                              text: widget.employee.userName,
                              height: 50,
                              width: 670,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            DetailsContainer(
                              title: S.of(context).email_Address.toUpperCase(),
                              text: widget.employee.email,
                              height: 50,
                              width: 670,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            DetailsContainer(
                              title: S.of(context).phoneNumber.toUpperCase(),
                              text: widget.employee.phoneNumber,
                              height: 50,
                              width: 670,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
