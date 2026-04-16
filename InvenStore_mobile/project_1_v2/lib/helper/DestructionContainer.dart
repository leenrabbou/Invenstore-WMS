// ignore_for_file: file_names

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Warehouse/Destruction%20Models/AnDestructionResponseModel.dart';
import 'package:project_1_v2/Models/Warehouse/Destruction%20Models/DestructionModel.dart';
import 'package:project_1_v2/Screens/DestructionDetailsScreen.dart';
import 'package:project_1_v2/Services/Warehouse/DestructionServices.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Destructioncontainer extends StatelessWidget {
  const Destructioncontainer({super.key, required this.destruction});
  final DestructionModel destruction;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final locale = Provider.of<LocalizationProvider>(
          context,
          listen: false,
        ).language!;
        try {
          AnDestructionCausesResponseModel response =
              await DestructionServices().showAnDestructionsService(
                locale,
                destruction.id,
              );
          if (!context.mounted) {
            return;
          }
          response.status == 1
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return DestructionDetailsScreen(destruction: destruction);
                    },
                  ),
                )
              : null;
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 10,
        ),
        child: Container(
          height: 190,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S().destructionNum,
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              destruction.destructionNum,
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 160,
                        child: Text(
                          S().productName,
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        destruction.product.name,
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 160,
                        child: Text(
                          S().destructionDate,
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        destruction.destructionedAt.substring(0, 10),
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 5),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 160,
                            child: Text(
                              S().quantity,
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              destruction.quantity.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 160,
                        child: Text(
                          S().causeOfDestruction,
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                      Text(
                        destruction.cause,
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary,
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
  }
}
