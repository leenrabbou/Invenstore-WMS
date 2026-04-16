import 'package:buymore/Models/Manager/Warehouse/WarehouseModel.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/DetailsContainer.dart';
import 'package:buymore/helper/Manager/ShowDialog/ShowDialog2.dart';
import 'package:buymore/main.dart';
import 'package:flutter/material.dart';

class WarehouseDetailsScreen extends StatelessWidget {
  const WarehouseDetailsScreen({super.key, required this.warehouse});
  final WarehouseModel warehouse;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          role != 'admin'
              ? const SizedBox()
              : Padding(
                  padding: EdgeInsets.only(
                      top: 10.0,
                      right: isArabic() ? 0 : 50,
                      left: isArabic() ? 50 : 0),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        const Color.fromARGB(255, 104, 168, 221)
                            .withOpacity(0.7),
                      ),
                    ),
                    onPressed: () {
                      // var provider = Provider.of<warehousesController>(context);
                      // provider.continueAsManager(warehouse.id.toString());
                    },
                    child: Text(
                      S.of(context).continueAsManager,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
          Padding(
            padding: EdgeInsets.only(
                top: 10.0,
                right: isArabic() ? 0 : 100,
                left: isArabic() ? 100 : 0),
            child: TextButton(
              onPressed: () {
                ShowDialog2().warhouseDialog(context, text: S().editWarehouse);
              },
              child: Text(
                S.of(context).editWarehouse,
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
                    Padding(
                      padding: EdgeInsets.only(
                          right: isArabic() ? 0 : 40,
                          left: isArabic() ? 40 : 0),
                      child: GestureDetector(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: warehouse.image == null
                                ? Image.asset(
                                    'images/image.png',
                                    height: 450,
                                    width: 300,
                                    fit: BoxFit.fill,
                                  )
                                : Image.network(
                                    '$imageUrl/${warehouse.image!}',
                                    height: 450,
                                    width: 300,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            warehouse.name,
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
                            text: warehouse.city,
                            height: 50,
                            width: 400),
                        const SizedBox(
                          height: 15,
                        ),
                        DetailsContainer(
                            title: S().state,
                            text: warehouse.state,
                            height: 50,
                            width: 400),
                        const SizedBox(
                          height: 15,
                        ),
                        DetailsContainer(
                            title: S().address,
                            text: warehouse.streetAddress,
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
