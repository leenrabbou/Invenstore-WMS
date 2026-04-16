// ignore_for_file: must_be_immutable, file_names

import 'package:buymore/Models/Manager/Distribution%20Center/CenterModel.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/DetailsContainer.dart';
import 'package:buymore/helper/Manager/ShowDialog/ShowDialog2.dart';
import 'package:buymore/main.dart';
import 'package:flutter/material.dart';

class CenterDetailsScreen extends StatelessWidget {
  CenterDetailsScreen({super.key, required this.center});
  CenterModel center;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          Padding(
            padding: EdgeInsets.only(
                top: 10.0,
                right: isArabic() ? 0 : 100,
                left: isArabic() ? 100 : 0),
            child: TextButton(
              onPressed: () {
                ShowDialog2().centersDialog(context, text: S().editCenter);
              },
              child: Text(
                S.of(context).editCenter,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 15),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 150, top: 40),
            child: Container(
              height: 400,
              width: 800,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  )
                ],
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            center.name,
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        DetailsContainer(
                            title: S().city,
                            text: 'Damascus',
                            height: 50,
                            width: 400),
                        const SizedBox(
                          height: 15,
                        ),
                        DetailsContainer(
                            title: S().state,
                            text: 'ALMazzah',
                            height: 50,
                            width: 400),
                        const SizedBox(
                          height: 15,
                        ),
                        DetailsContainer(
                            title: S().address,
                            text: 'aaaaaaaa',
                            height: 50,
                            width: 400),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
