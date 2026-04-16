import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomElevatedButton.dart';
import 'package:buymore/main.dart';
import 'package:flutter/material.dart';

class OrderShowDialog {
  Future<Map<String, dynamic>> editProductForOrderDialog(
      BuildContext context) async {
    Map<String, dynamic> data = {
      'quantity': null,
      'date': null,
    };

    bool dateEdit = false;
    int quantity = 0;
    DateTime currentDate = DateTime.now();
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
                  height: 400,
                  width: 450,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S().editProduct,
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
                          FittedBox(
                            child: Text(
                              'Quantity',
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
                            height: 10,
                          ),
                          Row(children: [
                            CustomElevatedButton(
                              onPressed: () {
                                setState(() {
                                  quantity > 0 ? quantity-- : null;
                                });
                              },
                              height: 30,
                              width: 35,
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              textSize: 15,
                              color: const Color.fromARGB(211, 199, 53, 43),
                              elevation: 5,
                              textcolor: Colors.white,
                              child: const Text(
                                '-',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '$quantity',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomElevatedButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              height: 30,
                              width: 35,
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              textSize: 15,
                              color: const Color.fromARGB(193, 29, 104, 165),
                              elevation: 5,
                              textcolor: Colors.white,
                              child: const Text(
                                '+',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 170,
                            child: Text(
                              'expired Date',
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
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
                                      currentDate = pickedDate;
                                      dateEdit = true;
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
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                height: 40,
                                width: 100,
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
                                  data['date'] = dateEdit
                                      ? currentDate.toString().substring(0, 10)
                                      : null;
                                  data['quantity'] =
                                      quantity == 0 ? null : quantity;

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
                        ],
                      ),
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
