// ignore_for_file: depend_on_referenced_packages

import 'dart:ui';
import 'package:buymore/Localization/LocalizationProvider.dart';
import 'package:buymore/Models/Manager/ImageModel.dart';
import 'package:buymore/Screens/Manager/ScreenSize.dart';
import 'package:buymore/Screens/SignInScreen.dart';
import 'package:buymore/Theme/Theme_Provider.dart';
import 'package:buymore/generated/l10n.dart';
import 'package:buymore/helper/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox('mainBox');

  bool isSigned = box.get('SignIn') ?? false;
  isSigned ? token = box.get('token') : '';

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => ImageModel(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => LocalizationProvider(),
        ),
      ],
      child: MyApp(
        isSigned: isSigned,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.isSigned});
  final bool isSigned;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose;
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LocalizationProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    ScreenSize().init(context);
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse},
      ),
      locale: languageProvider.language,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: themeProvider.currentTheme,
      debugShowCheckedModeBanner: false,
      home: const SignInScreen(),
    );
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
