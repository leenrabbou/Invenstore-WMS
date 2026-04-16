import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/main.dart';
import 'package:flutter/material.dart';

class ReportDialog {
  Future<Map<String, dynamic>> orderReportDialog(
    BuildContext context,
  ) async {
    Map<String, dynamic> data = {
      'frequency': null,
      'startDate': null,
      'endDate': null,
    };
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();
    bool editStartDate = false;
    bool editEndDate = false;

    List<String> frequency = ['daily', 'weekly', 'monthly', 'yearly'];
    bool frequencyEdit = false;
    String frequencyValue = frequency.first;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return Dialog(
                backgroundColor: Theme.of(context).colorScheme.background,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  height: 415,
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
                          'Customize Report',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: isArabic() ? 0 : 100,
                              left: isArabic() ? 100 : 0,
                              bottom: 15),
                          child: Divider(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(0.5),
                          ),
                        ),
                        Text(
                          'Start Date',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                                    startDate = pickedDate;
                                    editStartDate = true;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.calendar_month,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            Text(
                              '$startDate'.substring(0, 10),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'End Date',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                                    endDate = pickedDate;
                                    editEndDate = true;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.calendar_month,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            Text(
                              '$endDate'.substring(0, 10),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: 170,
                          child: Text(
                            'frequency',
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 160,
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
                                value: frequencyValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    frequencyValue = value!;
                                    frequencyEdit = true;
                                  });
                                },
                                items: frequency.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          color: Theme.of(context)
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
                          ],
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
                                onPressed: () async {
                                  data['startDate'] = editStartDate
                                      ? startDate.toString().substring(0, 10)
                                      : null;

                                  data['endDate'] = editEndDate
                                      ? endDate.toString().substring(0, 10)
                                      : null;

                                  data['frequency'] =
                                      frequencyEdit ? frequencyValue : null;
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
              );
            },
          );
        });
    return data;
  }

  Future<Map<String, dynamic>> productReportDialog(BuildContext context,
      {required bool isSpecific}) async {
    Map<String, dynamic> data = {
      'startDate': null,
      'endDate': null,
      'frquency': null
    };
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();
    bool editStartDate = false;
    bool editEndDate = false;
    List<String> frequency = ['daily', 'weekly', 'monthly', 'yearly'];
    bool frequencyEdit = false;
    String frequencyValue = frequency.first;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return Dialog(
                backgroundColor: Theme.of(context).colorScheme.background,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  height: isSpecific ? 415 : 350,
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
                          'Customize Report',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: isArabic() ? 0 : 100,
                              left: isArabic() ? 100 : 0,
                              bottom: 15),
                          child: Divider(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(0.5),
                          ),
                        ),
                        Text(
                          'Start Date',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                                    startDate = pickedDate;
                                    editStartDate = true;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.calendar_month,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            Text(
                              '$startDate'.substring(0, 10),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'End Date',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                                    endDate = pickedDate;
                                    editEndDate = true;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.calendar_month,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            Text(
                              '$endDate'.substring(0, 10),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        isSpecific
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 170,
                                    child: Text(
                                      'frequency',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 160,
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
                                          value: frequencyValue,
                                          onChanged: (String? value) {
                                            setState(() {
                                              frequencyValue = value!;
                                              frequencyEdit = true;
                                            });
                                          },
                                          items: frequency
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Theme.of(context)
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
                                    ],
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
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
                                onPressed: () async {
                                  data['startDate'] = editStartDate
                                      ? startDate.toString().substring(0, 10)
                                      : null;

                                  data['endDate'] = editEndDate
                                      ? endDate.toString().substring(0, 10)
                                      : null;
                                  data['frequency'] =
                                      frequencyEdit ? frequencyValue : null;
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
              );
            },
          );
        });
    return data;
  }
}
