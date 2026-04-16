// ignore_for_file: file_names

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Manager/ImageModel.dart';
import 'package:buymore/Services/Warehouse/ProfileService.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/DetailsContainer.dart';
import 'package:buymore/helper/Manager/ShowDialog/ShowDialog.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.isWarehouse});
  final bool isWarehouse;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _onRefresh() async {
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    await Future.delayed(
      const Duration(seconds: 2),
    );
    try {
      final dynamic newData;
      if (widget.isWarehouse) {
        newData = await ProfileServices().showProfileWarehouseService(locale);
        setState(() {
          userAccount = newData.data;
        });
      } else {
        newData = await ProfileServices().showProfileManagerService(locale);
        setState(() {
          managerAccount = newData.data;
        });
      }
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
        actions: [
          Padding(
            padding: EdgeInsets.only(
                top: 10.0,
                right: isArabic() ? 0 : 100,
                left: isArabic() ? 100 : 0),
            child: TextButton(
              onPressed: () {
                widget.isWarehouse
                    ? ShowDialog().editProfileDialog(context)
                    : ShowDialog().editProfileForManagerDialog(context);
              },
              child: Text(
                S.of(context).editProfile,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 15),
              ),
            ),
          ),
        ],
      ),
      body: LiquidPullToRefresh(
        onRefresh: _onRefresh,
        color: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.primary,
        height: 100,
        child: ListView(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 300,
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
                        Consumer<ImageModel>(builder: (context, model, child) {
                          return model.pickedImage2 == null
                              ? userAccount != null
                                  ? userAccount!.image == null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.asset(
                                            defaultImage,
                                            height: 220,
                                            width: 220,
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.network(
                                            '$imageUrl/${userAccount!.image!}',
                                            height: 220,
                                            width: 220,
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                  : managerAccount!.image == null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.asset(
                                            defaultImage,
                                            height: 220,
                                            width: 220,
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.network(
                                            '$imageUrl/${managerAccount!.image!}',
                                            height: 220,
                                            width: 220,
                                            fit: BoxFit.fill,
                                          ),
                                        )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.memory(
                                    model.webImage2,
                                    height: 220,
                                    width: 220,
                                    fit: BoxFit.fill,
                                  ),
                                );
                        }),
                        const SizedBox(
                          height: 15,
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
                      widget.isWarehouse
                          ? Padding(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
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
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      DetailsContainer(
                                        title: S
                                            .of(context)
                                            .fullName
                                            .toUpperCase(),
                                        text: userAccount != null
                                            ? userAccount!.fullName
                                            : '',
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
                                            text: userAccount != null
                                                ? userAccount!.birthDate
                                                : '',
                                            height: 50,
                                            width: 330,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          DetailsContainer(
                                            title: S.of(context).gender,
                                            text: userAccount != null
                                                ? userAccount!.gender
                                                : '',
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
                                        text: userAccount != null
                                            ? userAccount!.ssn
                                            : '',
                                        height: 50,
                                        width: 670,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          DetailsContainer(
                                            title: S
                                                .of(context)
                                                .city
                                                .toUpperCase(),
                                            text: userAccount != null
                                                ? userAccount!.city
                                                : '',
                                            height: 50,
                                            width: 330,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          DetailsContainer(
                                            title: S
                                                .of(context)
                                                .state
                                                .toUpperCase(),
                                            text: userAccount != null
                                                ? userAccount!.state
                                                : '',
                                            height: 50,
                                            width: 330,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      DetailsContainer(
                                        title:
                                            S.of(context).address.toUpperCase(),
                                        text: userAccount != null
                                            ? userAccount!.address == null
                                                ? '--'
                                                : userAccount!.address!
                                            : '',
                                        height: 50,
                                        width: 670,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      widget.isWarehouse
                          ? const SizedBox(
                              height: 15,
                            )
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: widget.isWarehouse ? 270 : 210,
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
                                FittedBox(
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
                                const SizedBox(
                                  height: 10,
                                ),
                                DetailsContainer(
                                  title: S.of(context).userName.toUpperCase(),
                                  text: userAccount != null
                                      ? userAccount!.userName
                                      : managerAccount!.userName,
                                  height: 50,
                                  width: 670,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                DetailsContainer(
                                  title:
                                      S.of(context).email_Address.toUpperCase(),
                                  text: userAccount != null
                                      ? userAccount!.email
                                      : managerAccount!.email,
                                  height: 50,
                                  width: 670,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                userAccount != null
                                    ? DetailsContainer(
                                        title: S
                                            .of(context)
                                            .phoneNumber
                                            .toUpperCase(),
                                        text: userAccount!.phoneNumber,
                                        height: 50,
                                        width: 670,
                                      )
                                    : const SizedBox.shrink(),
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
