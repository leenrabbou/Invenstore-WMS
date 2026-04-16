import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Services/Reports/downloadReportServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomSnackBar.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class DownloadReportsDialog {
  void orderReportDialog(BuildContext context, {required String type}) async {
    Map<String, dynamic> data = {
      'frequency': null,
      'startDate': null,
      'endDate': null,
    };
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();
    bool editStartDate = false;
    bool editEndDate = false;
    bool isLoadingExcel = false;
    bool isLoadingPDF = false;

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
                  height: 420,
                  width: 610,
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
                                left: isArabic() ? 30 : 0,
                                right: isArabic() ? 0 : 30,
                                top: 5,
                                bottom: 10,
                                textSize: 15,
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
                                onPressed: isLoadingExcel
                                    ? () {}
                                    : () async {
                                        data['startDate'] = editStartDate
                                            ? startDate
                                                .toString()
                                                .substring(0, 10)
                                            : null;

                                        data['endDate'] = editEndDate
                                            ? endDate
                                                .toString()
                                                .substring(0, 10)
                                            : null;

                                        data['frequency'] = frequencyEdit
                                            ? frequencyValue
                                            : null;
                                        try {
                                          final locale =
                                              Provider.of<LocalizationProvider>(
                                                      context,
                                                      listen: false)
                                                  .language!;
                                          setState(() {
                                            isLoadingExcel = true;
                                          });
                                          int response =
                                              await DownloadReportServices()
                                                  .downloadExcelService(
                                                      data['startDate'],
                                                      data['endDate'],
                                                      data['frequency'],
                                                      type,
                                                      locale);
                                          setState(() {
                                            isLoadingExcel = false;
                                          });
                                          response == 200
                                              ? CustomSnackBar().showToast(
                                                  'The Excel file is being downloaded..')
                                              : CustomSnackBar().showToast(
                                                  'unknown error accured');
                                          Navigator.pop(context);
                                        } catch (e) {
                                          if (kDebugMode) {
                                            print(e);
                                          }
                                        }
                                      },
                                height: 40,
                                width: 170,
                                left: 0,
                                right: 0,
                                top: 5,
                                bottom: 10,
                                textSize: isArabic() ? 15 : 15,
                                color: const Color.fromARGB(255, 29, 104, 165),
                                elevation: 5,
                                textcolor: Colors.white,
                                child: isLoadingExcel
                                    ? SpinKitThreeInOut(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        size: 20,
                                      )
                                    : const Text(
                                        'download as Excel',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                              CustomElevatedButton(
                                onPressed: isLoadingPDF
                                    ? () {}
                                    : () async {
                                        data['startDate'] = editStartDate
                                            ? startDate
                                                .toString()
                                                .substring(0, 10)
                                            : null;

                                        data['endDate'] = editEndDate
                                            ? endDate
                                                .toString()
                                                .substring(0, 10)
                                            : null;

                                        data['frequency'] = frequencyEdit
                                            ? frequencyValue
                                            : null;
                                        try {
                                          final locale =
                                              Provider.of<LocalizationProvider>(
                                                      context,
                                                      listen: false)
                                                  .language!;
                                          setState(() {
                                            isLoadingPDF = true;
                                          });
                                          int response =
                                              await DownloadReportServices()
                                                  .downloadPDFService(
                                                      data['startDate'],
                                                      data['endDate'],
                                                      data['frequency'],
                                                      type,
                                                      locale);
                                          setState(() {
                                            isLoadingPDF = false;
                                          });
                                          response == 200
                                              ? CustomSnackBar().showToast(
                                                  'The PDF file is being downloaded..')
                                              : CustomSnackBar().showToast(
                                                  'unknown error accured');
                                          Navigator.pop(context);
                                        } catch (e) {
                                          if (kDebugMode) {
                                            print(e);
                                          }
                                        }
                                      },
                                height: 40,
                                width: 170,
                                left: 30,
                                right: 30,
                                top: 5,
                                bottom: 10,
                                textSize: isArabic() ? 15 : 15,
                                color: const Color.fromARGB(255, 29, 104, 165),
                                elevation: 5,
                                textcolor: Colors.white,
                                child: isLoadingPDF
                                    ? SpinKitThreeInOut(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        size: 20,
                                      )
                                    : const Text(
                                        'download as PDF',
                                        style: TextStyle(
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
  }
}
