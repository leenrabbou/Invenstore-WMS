// ignore_for_file: must_be_immutable, file_names

import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Warehouse/Destruction%20Models/DestructionModel.dart';
import 'package:project_1_v2/Services/Warehouse/DestructionServices.dart';
import 'package:project_1_v2/generated/l10n.dart';
import 'package:project_1_v2/helper/DetailsContainer.dart';
import 'package:project_1_v2/helper/ProductDestructionContainer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class DestructionDetailsScreen extends StatefulWidget {
  DestructionDetailsScreen({super.key, required this.destruction});
  DestructionModel destruction;

  @override
  State<DestructionDetailsScreen> createState() =>
      _DestructionDetailsScreenState();
}

class _DestructionDetailsScreenState extends State<DestructionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Future<void> onRefresh() async {
      final locale = Provider.of<LocalizationProvider>(
        context,
        listen: false,
      ).language!;
      await Future.delayed(const Duration(seconds: 2));
      try {
        final newData = await DestructionServices().showAnDestructionsService(
          locale,
          widget.destruction.id,
        );

        setState(() {
          widget.destruction = newData.data;
        });
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          S.of(context).destruction,
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
      ),
      body: LiquidPullToRefresh(
        onRefresh: onRefresh,
        color: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.primary,
        height: 100,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 280,
                width: 600,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailsContainer(
                        title: S().destructionNum,
                        text: widget.destruction.destructionNum,
                        height: 50,
                        width: 170,
                      ),
                      DetailsContainer(
                        title: S().destructionDate,
                        text: widget.destruction.destructionedAt,
                        height: 50,
                        width: 170,
                      ),
                      DetailsContainer(
                        title: S().destructionBy,
                        text: widget.destruction.destructionedByName,
                        height: 50,
                        width: 160,
                      ),
                      DetailsContainer(
                        title: S().quantity,
                        text: widget.destruction.quantity.toString(),
                        height: 50,
                        width: 170,
                      ),
                      DetailsContainer(
                        title: S().causeOfDestruction,
                        text: widget.destruction.cause,
                        height: 50,
                        width: 160,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ProductDestructionContainer(product: widget.destruction.product),
          ],
        ),
      ),
    );
  }
}
