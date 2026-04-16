// ignore_for_file: file_names, avoid_web_libraries_in_flutter

import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Manager/ImageModel.dart';
import 'package:buymore/Models/Manager/SideBarModel.dart';
import 'package:buymore/Models/Notifications/NotificationResponseModel.dart';
import 'package:buymore/Screens/Manager/SideBarDrawer.dart';
import 'package:buymore/Screens/SignInScreen.dart';
import 'package:buymore/Services/LogIn/LogOutService.dart';
import 'package:buymore/Services/notifications/NotificationServices.dart';
import 'package:buymore/Theme/Theme_Provider.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:buymore/helper/Manager/Custom%20Widgets/CustomSnackBar.dart';
import 'package:buymore/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'dart:js' as js;
import 'dart:html' as html;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<NavigatorState> mainKey = GlobalKey<NavigatorState>();

  int notificationCount = 0;
  List<String> notifications = [];
  bool isView = false;
  void selectedPage(int index) {
    setState(() {
      isSelected = index;
    });
    mainKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) =>
              SideBarModel(context).sideBarItems[isSelected]["Navigator"],
        ),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    _initPusher();
    getNotificationsList();
  }

  void _initPusher() {
    if (kIsWeb) {
      js.context.callMethod('initializePusher', [userId]);

      html.window.removeEventListener('notification', _handlePusherEvent);
      html.window.addEventListener('notification', _handlePusherEvent);

      if (kDebugMode) {
        print("Pusher initialized for web");
      }
    }
  }

  void _handlePusherEvent(html.Event event) {
    final customEvent = event as html.CustomEvent;
    final data = customEvent.detail;

    if (kDebugMode) {
      print('Received raw data: $data');
    }

    if (data is Map) {
      if (kDebugMode) {
        print('Decoded data: $data');
      }
      final dataValueAr = data['message_ar'];
      final dataValueEn = data['message_en'];
      isArabic()
          ? notifications.add(dataValueAr)
          : notifications.add(dataValueEn);
      setState(() {
        notificationCount++;
      });
      if (kDebugMode) {
        print('Value of "Data": $dataValueAr');
        print('Value of "Data": $dataValueEn');
      }
    } else {
      if (kDebugMode) {
        print('Unexpected data format: $data');
      }
    }
  }

  bool switchValue = false;
  void getNotificationsList() async {
    try {
      NotificationResponseModel response = await NotificationServices()
          .getAllnotificationsService(
              Provider.of<LocalizationProvider>(context, listen: false)
                  .language!);
      for (int i = 0; i < response.data.length; i++) {
        isArabic()
            ? notifications.add(response.data[i].messageAr)
            : notifications.add(response.data[i].messageEn);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final locale =
        Provider.of<LocalizationProvider>(context, listen: false).language!;
    final languageProvider = Provider.of<LocalizationProvider>(context);
    Locale? value = languageProvider.language;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Row(
            children: [
              Image.asset(
                'images/MainLogo.png',
                height: 40,
                width: 40,
              ),
              const SizedBox(
                width: 5,
              ),
              FittedBox(
                child: Text(
                  'InvenStore',
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontFamily: 'Righteous',
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                PopupMenuButton<String>(
                  onOpened: () async {
                    try {
                      int response = await NotificationServices()
                          .markAsReadnotificationsService(locale);
                      setState(() {
                        response == 200 ? notificationCount = 0 : null;
                      });
                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                    }
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onSelected: (String value) {},
                  itemBuilder: (BuildContext context) {
                    return notifications.isEmpty
                        ? [
                            PopupMenuItem<String>(
                              value: 'No notifications',
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'No notifications',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                ),
                              ),
                            ),
                          ]
                        : notifications.map((String notification) {
                            return PopupMenuItem<String>(
                              value: notification,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  notification,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                ),
                              ),
                            );
                          }).toList();
                  },
                ),
                if (notificationCount > 0)
                  Positioned(
                    top: 8,
                    left: 22,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        maxWidth: 17,
                        maxHeight: 17,
                      ),
                      child: Center(
                        child: Text(
                          notificationCount > 9 ? '+9' : '$notificationCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              cardColor:
                  Theme.of(context).colorScheme.background.withOpacity(0.8),
            ),
            child: PopupMenuButton(
                onSelected: (value) {
                  if (value == "language") {
                  } else if (value == "darkMode") {
                    themeProvider.toggleTheme();
                  }
                },
                icon: const Icon(
                  Icons.settings,
                ),
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        value: "language",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.language, size: 20),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  S.of(context).language,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                              ],
                            ),
                            DropdownButton(
                                value: value,
                                items: [
                                  DropdownMenuItem(
                                    value: Locale('en'),
                                    child: Text(
                                      'English',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: Locale('ar'),
                                    child: Text(
                                      'Arabic',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ),
                                ],
                                onChanged: (Locale? locale) {
                                  languageProvider.setLanguage(locale);

                                  setState(() {
                                    value = locale;
                                  });
                                }),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "darkMode",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.dark_mode, size: 20),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  S.of(context).darkTheme,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                              ],
                            ),
                            FlutterSwitch(
                                width: 35,
                                height: 20,
                                toggleSize: 10,
                                activeColor:
                                    const Color.fromARGB(255, 104, 168, 221),
                                value: themeProvider.darkTheme,
                                onToggle: (value) {
                                  themeProvider.setTheme(value);
                                }),
                          ],
                        ),
                      ),
                    ]),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              right: isArabic() ? 15 : 50,
              left: isArabic() ? 50 : 15,
            ),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = 1;
                  });
                },
                child: Row(
                  children: [
                    userAccount != null
                        ? CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              '$imageUrl/${userAccount!.image!}',
                            ),
                          )
                        : managerAccount != null
                            ? CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  '$imageUrl/${managerAccount!.image!}',
                                ),
                              )
                            : CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(defaultImage),
                              ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: isArabic() ? 0 : 10.0,
                          right: isArabic() ? 10 : 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(
                              userAccount != null
                                  ? userAccount!.userName
                                  : managerAccount!.userName,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              role,
                              style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        cardColor: Theme.of(context).colorScheme.background,
                      ),
                      child: PopupMenuButton(
                          onSelected: (value) async {
                            if (value == "another account") {
                            } else if (value == "logout") {
                              int response;
                              response = await LogOutService().logOut(locale);
                              if (response == 200) {
                                if (!context.mounted) {
                                  return;
                                }
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                  return const SignInScreen();
                                }));

                                isSelected = 0;
                              } else {
                                CustomSnackBar().showToast(
                                    'Something wrong! Check your connection and try again later.');
                              }
                            }
                          },
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                          ),
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          itemBuilder: (BuildContext context) => [
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Consumer<ImageModel>(
                                          builder: (context, model, child) {
                                        return model.pickedImage2 == null
                                            ? userAccount != null
                                                ? userAccount!.image == null
                                                    ? CircleAvatar(
                                                        radius: 20,
                                                        backgroundImage:
                                                            AssetImage(
                                                                defaultImage),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 20,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          '$imageUrl/${userAccount!.image!}',
                                                        ),
                                                      )
                                                : managerAccount!.image == null
                                                    ? CircleAvatar(
                                                        radius: 20,
                                                        backgroundImage:
                                                            AssetImage(
                                                                defaultImage),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 20,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          '$imageUrl/${managerAccount!.image!}',
                                                        ),
                                                      )
                                            : CircleAvatar(
                                                radius: 20,
                                                backgroundImage: MemoryImage(
                                                    model.webImage2),
                                              );
                                      }),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: isArabic() ? 0 : 10.0,
                                            right: isArabic() ? 10 : 0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FittedBox(
                                              child: Text(
                                                userAccount != null
                                                    ? userAccount!.userName
                                                    : managerAccount!.userName,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                ),
                                              ),
                                            ),
                                            FittedBox(
                                              child: Text(
                                                role,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "another account",
                                  child: Row(
                                    children: [
                                      const Icon(Icons.login, size: 20),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        S.of(context).anotherAccount,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "logout",
                                  child: Row(
                                    children: [
                                      const Icon(Icons.logout, size: 20),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        S.of(context).logout,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          SizedBox(
            width: 260,
            child: SideBarDrawer(
              ontapped: selectedPage,
            ),
          ),
          Expanded(
            child: Navigator(
              key: mainKey,
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => SideBarModel(context)
                      .sideBarItems[isSelected]["Navigator"],
                );
              },
            ),
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    if (kIsWeb) {
      js.context.callMethod('disposePusher', [userId]);
    }

    super.dispose();
  }
}
