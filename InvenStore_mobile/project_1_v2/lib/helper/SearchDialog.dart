// ignore_for_file: file_names

import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/CustomElevatedButton.dart';
import 'package:project_1_v2/helper/CustomTextField.dart';
import 'package:project_1_v2/main.dart';
import 'package:flutter/material.dart';

class SearchDialog {
  Future<Map<String, dynamic>> orderFilterDialog(BuildContext context) async {
    Map<String, dynamic> data = {
      'status': null,
      'orderedBy': null,
      'before': null,
      'after': null,
      'id': null,
      'date': null,
      'cost': null,
      'cheaperThan': null,
      'expensiveThan': null,
      'name': null,
      'city': null,
      'state': null,
      'address': null,
    };

    final TextEditingController nameController = TextEditingController();
    final TextEditingController costController = TextEditingController();
    final TextEditingController cheaperThanController = TextEditingController();
    final TextEditingController moreExpensiveThancostController =
        TextEditingController();
    List<String> status = [
      S().pending,
      S().delievered,
      S().accepted,
      S().underPreparing,
      S().canceled,
      S().deleted,
      S().underShipping,
    ];
    bool afterEdit = false,
        beforeEdit = false,
        editStatus = false,
        dateEdit = false;
    DateTime beforeDate = DateTime.now();
    DateTime afterDate = DateTime.now();
    DateTime date = DateTime.now();
    String statusValue = status.first;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Dialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: 600,
                width: 550,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S().filters,
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
                        Row(
                          children: [
                            SizedBox(
                              width: 170,
                              child: Text(
                                S().status,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 160,
                              child: DropdownButton<String>(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary.withOpacity(0.5),
                                ),
                                iconSize: 36,
                                isExpanded: true,
                                value: statusValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    statusValue = value!;
                                    editStatus = true;
                                  });
                                },
                                items: status.map<DropdownMenuItem<String>>((
                                  String value,
                                ) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                underline: const SizedBox(width: 120),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                S().orderedBy,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
                            CustomTextField(
                              text: null,
                              hint: S().enterName,
                              controller: nameController,
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              height: 60,
                              width: 150,
                              maxLines: false,
                              errorMsg: S.of(context).required,
                              fillColor: null,
                              prefix: null,
                              suffix: false,
                              obscure: false,
                              inputFormatter: null,
                              maxLength: null,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                S().before,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
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
                                              onSurface: Theme.of(
                                                context,
                                              ).colorScheme.onBackground,
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
                                    beforeDate = pickedDate;
                                    beforeEdit = true;
                                  });
                                }
                              },
                              icon: const Icon(Icons.calendar_month),
                            ),
                            Text('$beforeDate'.substring(0, 10)),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            SizedBox(
                              width: 170,
                              child: Text(
                                S().after,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
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
                                              onSurface: Theme.of(
                                                context,
                                              ).colorScheme.onBackground,
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
                                    afterDate = pickedDate;
                                    afterEdit = true;
                                  });
                                }
                              },
                              icon: const Icon(Icons.calendar_month),
                            ),
                            Text('$afterDate'.substring(0, 10)),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 170,
                              child: Text(
                                S().cost,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
                            CustomTextField(
                              text: null,
                              hint: S().enterCost,
                              controller: costController,
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              height: 60,
                              width: 250,
                              maxLines: false,
                              errorMsg: S.of(context).required,
                              fillColor: null,
                              prefix: null,
                              suffix: false,
                              obscure: false,
                              inputFormatter: null,
                              maxLength: null,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 170,
                              child: Text(
                                'Cheaper Than',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
                            CustomTextField(
                              text: null,
                              hint: S().enterCost,
                              controller: cheaperThanController,
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              height: 60,
                              width: 250,
                              maxLines: false,
                              errorMsg: S.of(context).required,
                              fillColor: null,
                              prefix: null,
                              suffix: false,
                              obscure: false,
                              inputFormatter: null,
                              maxLength: null,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 170,
                              child: Text(
                                'more expensive than',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
                            CustomTextField(
                              text: null,
                              hint: S().enterCost,
                              controller: moreExpensiveThancostController,
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              height: 60,
                              width: 250,
                              maxLines: false,
                              errorMsg: S.of(context).required,
                              fillColor: null,
                              prefix: null,
                              suffix: false,
                              obscure: false,
                              inputFormatter: null,
                              maxLength: null,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            SizedBox(
                              width: 170,
                              child: Text(
                                S().date,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
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
                                              onSurface: Theme.of(
                                                context,
                                              ).colorScheme.onBackground,
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
                                    date = pickedDate;
                                    dateEdit = true;
                                  });
                                }
                              },
                              icon: const Icon(Icons.calendar_month),
                            ),
                            Text('$date'.substring(0, 10)),
                          ],
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
                                width: 150,
                                left: isArabic() ? 50 : 0,
                                right: isArabic() ? 0 : 50,
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
                                    // color: Colors.white,
                                  ),
                                ),
                              ),
                              CustomElevatedButton(
                                onPressed: () async {
                                  data['status'] = editStatus
                                      ? statusValue
                                      : null;
                                  data['name'] = nameController.text.isNotEmpty
                                      ? nameController.text
                                      : null;
                                  data['before'] = beforeEdit
                                      ? beforeDate.toString().substring(0, 10)
                                      : null;
                                  data['after'] = afterEdit
                                      ? afterDate.toString().substring(0, 10)
                                      : null;
                                  data['date'] = dateEdit
                                      ? date.toString().substring(0, 10)
                                      : null;
                                  data['cost'] = costController.text.isNotEmpty
                                      ? double.parse(costController.text)
                                      : null;

                                  data['cheaperThan'] =
                                      cheaperThanController.text.isNotEmpty
                                      ? cheaperThanController.text
                                      : null;

                                  data['expensiveThan'] =
                                      moreExpensiveThancostController
                                          .text
                                          .isNotEmpty
                                      ? moreExpensiveThancostController.text
                                      : null;
                                  Navigator.pop(context, data);
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
                                child: Text(
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
      },
    );
    return data;
  }

  Future<Map<String, dynamic>> productsFilterDialog(
    BuildContext context, {
    required bool isAll,
  }) async {
    Map<String, dynamic> data = {
      'name': null,
      'manufacturer': null,
      'category': null,
      'cheaperThan': null,
      'expensiveThan': null,
      'status': null,
      'expireBefore': null,
      'expireAfter': null,
      'lessThan': null,
      'moreThan': null,
    };

    final TextEditingController nameController = TextEditingController();
    final TextEditingController manufacturerController =
        TextEditingController();
    final TextEditingController cheaperThanController = TextEditingController();

    final TextEditingController categoryController = TextEditingController();
    final TextEditingController lessThanController = TextEditingController();
    final TextEditingController moreThanController = TextEditingController();
    final TextEditingController moreExpensiveThancostController =
        TextEditingController();
    List<String> status = ['valid', 'expired'];
    bool afterEdit = false, beforeEdit = false, editStatus = false;
    DateTime beforeDate = DateTime.now();
    DateTime afterDate = DateTime.now();
    String statusValue = status.first;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Dialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: 600,
                width: 550,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S().filters,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 170,
                              child: Text(
                                'name',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
                            CustomTextField(
                              text: null,
                              hint: S().enterName,
                              controller: nameController,
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              height: 70,
                              width: 270,
                              maxLines: false,
                              errorMsg: S.of(context).required,
                              fillColor: null,
                              prefix: null,
                              suffix: false,
                              obscure: false,
                              inputFormatter: null,
                              maxLength: null,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 170,
                              child: Text(
                                S().manufacturer,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
                            CustomTextField(
                              text: null,
                              hint: 'enter Manufacturer Name',
                              controller: manufacturerController,
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              height: 70,
                              width: 270,
                              maxLines: false,
                              errorMsg: S.of(context).required,
                              fillColor: null,
                              prefix: null,
                              suffix: false,
                              obscure: false,
                              inputFormatter: null,
                              maxLength: null,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 170,
                              child: Text(
                                S().category,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
                            CustomTextField(
                              text: null,
                              hint: 'enter Category Name',
                              controller: categoryController,
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              height: 70,
                              width: 270,
                              maxLines: false,
                              errorMsg: S.of(context).required,
                              fillColor: null,
                              prefix: null,
                              suffix: false,
                              obscure: false,
                              inputFormatter: null,
                              maxLength: null,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 170,
                              child: Text(
                                'cheaperThan',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
                            CustomTextField(
                              text: null,
                              hint: S().enterCost,
                              controller: cheaperThanController,
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              height: 70,
                              width: 270,
                              maxLines: false,
                              errorMsg: S.of(context).required,
                              fillColor: null,
                              prefix: null,
                              suffix: false,
                              obscure: false,
                              inputFormatter: null,
                              maxLength: null,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 170,
                              child: Text(
                                'more Expensive',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
                            CustomTextField(
                              text: null,
                              hint: S().enterCost,
                              controller: moreExpensiveThancostController,
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              height: 70,
                              width: 270,
                              maxLines: false,
                              errorMsg: S.of(context).required,
                              fillColor: null,
                              prefix: null,
                              suffix: false,
                              obscure: false,
                              inputFormatter: null,
                              maxLength: null,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        isAll
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      S().status,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
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
                                      value: statusValue,
                                      onChanged: (String? value) {
                                        setState(() {
                                          statusValue = value!;
                                          editStatus = true;
                                        });
                                      },
                                      items: status
                                          .map<DropdownMenuItem<String>>((
                                            String value,
                                          ) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          })
                                          .toList(),
                                      underline: const SizedBox(width: 120),
                                    ),
                                  ),
                                ],
                              ),
                        isAll
                            ? const SizedBox.shrink()
                            : const SizedBox(height: 15),
                        isAll
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      'expire Before',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      DateTime?
                                      pickedDate = await showDatePicker(
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
                                                    onSurface: Theme.of(
                                                      context,
                                                    ).colorScheme.onBackground,
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
                                          beforeDate = pickedDate;
                                          beforeEdit = true;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.calendar_month),
                                  ),
                                  Text('$beforeDate'.substring(0, 10)),
                                ],
                              ),
                        isAll
                            ? const SizedBox.shrink()
                            : const SizedBox(height: 15),
                        isAll
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      'expire After',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      DateTime?
                                      pickedDate = await showDatePicker(
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
                                                    onSurface: Theme.of(
                                                      context,
                                                    ).colorScheme.onBackground,
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
                                          afterDate = pickedDate;
                                          afterEdit = true;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.calendar_month),
                                  ),
                                  Text('$afterDate'.substring(0, 10)),
                                ],
                              ),
                        isAll
                            ? const SizedBox.shrink()
                            : const SizedBox(height: 15),
                        isAll
                            ? const SizedBox.shrink()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 170,
                                    child: Text(
                                      'quantity less than',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                      ),
                                    ),
                                  ),
                                  CustomTextField(
                                    text: null,
                                    hint: 'enter quantity',
                                    controller: lessThanController,
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    height: 70,
                                    width: 270,
                                    maxLines: false,
                                    errorMsg: S.of(context).required,
                                    fillColor: null,
                                    prefix: null,
                                    suffix: false,
                                    obscure: false,
                                    inputFormatter: null,
                                    maxLength: null,
                                  ),
                                ],
                              ),
                        isAll
                            ? const SizedBox.shrink()
                            : const SizedBox(height: 15),
                        isAll
                            ? const SizedBox.shrink()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 170,
                                    child: Text(
                                      'quantity more than',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                      ),
                                    ),
                                  ),
                                  CustomTextField(
                                    text: null,
                                    hint: 'enter quantity',
                                    controller: moreThanController,
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    height: 70,
                                    width: 270,
                                    maxLines: false,
                                    errorMsg: S.of(context).required,
                                    fillColor: null,
                                    prefix: null,
                                    suffix: false,
                                    obscure: false,
                                    inputFormatter: null,
                                    maxLength: null,
                                  ),
                                ],
                              ),
                        isAll
                            ? const SizedBox.shrink()
                            : const SizedBox(height: 15),
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
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              CustomElevatedButton(
                                onPressed: () async {
                                  data['manufacturer'] =
                                      manufacturerController.text.isNotEmpty
                                      ? manufacturerController.text
                                      : null;

                                  data['category'] =
                                      categoryController.text.isNotEmpty
                                      ? categoryController.text
                                      : null;

                                  data['lessThan'] =
                                      lessThanController.text.isNotEmpty
                                      ? lessThanController.text
                                      : null;

                                  data['moreThan'] =
                                      moreThanController.text.isNotEmpty
                                      ? moreThanController.text
                                      : null;
                                  data['status'] = editStatus
                                      ? statusValue
                                      : null;
                                  data['name'] = nameController.text.isNotEmpty
                                      ? nameController.text
                                      : null;
                                  data['expireBefore'] = beforeEdit
                                      ? beforeDate.toString().substring(0, 10)
                                      : null;
                                  data['expireAfter'] = afterEdit
                                      ? afterDate.toString().substring(0, 10)
                                      : null;

                                  data['cheaperThan'] =
                                      cheaperThanController.text.isNotEmpty
                                      ? cheaperThanController.text
                                      : null;

                                  data['expensiveThan'] =
                                      moreExpensiveThancostController
                                          .text
                                          .isNotEmpty
                                      ? moreExpensiveThancostController.text
                                      : null;
                                  Navigator.pop(context, data);
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
                                child: Text(
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
      },
    );
    return data;
  }
}
