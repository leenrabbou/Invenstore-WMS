// ignore_for_file: file_names, must_be_immutable

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Warehouse/Destruction%20Models/DestructionModel.dart';
import 'package:buymore/Services/Warehouse/DestructionServices.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/DetailsContainer.dart';
import 'package:buymore/main.dart';
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
  Future<void> _onRefresh() async {
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    await Future.delayed(
      const Duration(seconds: 2),
    );
    try {
      final newData = await DestructionServices()
          .showAnDestructionsService(locale, widget.destruction.id);
      setState(() {
        widget.destruction = newData.data;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Destruction Details',
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
        onRefresh: _onRefresh,
        color: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.primary,
        height: 100,
        child: ListView(
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 1100,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              height: 240,
                              width: 730,
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
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                    Row(
                                      children: [
                                        DetailsContainer(
                                          title: S().destructionNum,
                                          text:
                                              widget.destruction.destructionNum,
                                          height: 50,
                                          width: 330,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        DetailsContainer(
                                          title: S().destructionDate,
                                          text: widget.destruction
                                                      .destructionedAt !=
                                                  null
                                              ? widget
                                                  .destruction.destructionedAt!
                                              : '--',
                                          height: 50,
                                          width: 330,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        DetailsContainer(
                                          title: S().destructionBy,
                                          text: widget
                                              .destruction.destructionedByName,
                                          height: 50,
                                          width: 330,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        DetailsContainer(
                                          title: S().quantity,
                                          text: widget.destruction.quantity
                                              .toString(),
                                          height: 50,
                                          width: 330,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        DetailsContainer(
                                          title: S().causeOfDestruction,
                                          text: widget.destruction.cause,
                                          height: 50,
                                          width: 330,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: FittedBox(
                              child: Text(
                                S().productData,
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
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              height: 450,
                              width: 900,
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
                                padding: const EdgeInsets.all(30.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: isArabic() ? 0 : 40,
                                          left: isArabic() ? 40 : 0),
                                      child: GestureDetector(
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: widget.destruction.product
                                                        .image ==
                                                    null
                                                ? Image.asset(
                                                    'images/image.png',
                                                    height: 500,
                                                    width: 350,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.network(
                                                    '$imageUrl/${widget.destruction.product.image!}',
                                                    height: 500,
                                                    width: 350,
                                                    fit: BoxFit.fill,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          child: Text(
                                            widget.destruction.product.name,
                                            style: TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                        ),
                                        FittedBox(
                                          child: Text(
                                            widget.destruction.product
                                                .manufacturer,
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: FittedBox(
                                            child: Text(
                                              S.of(context).description,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 350,
                                          height: 130,
                                          child: Text(
                                            widget.destruction.product
                                                .description,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                            maxLines: 7,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          ),
                                        ),
                                        FittedBox(
                                          child: Text(
                                            '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: Text(
                                                S.of(context).price,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 40),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: FittedBox(
                                                child: Text(
                                                  '${widget.destruction.product.price} SYP',
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 40),
                                          ],
                                        ),
                                      ],
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
          ],
        ),
      ),
    );
  }
}
