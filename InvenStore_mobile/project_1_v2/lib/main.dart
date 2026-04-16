import 'package:flutter/material.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project_1_v2/Localization/LocalizationProvider.dart';
import 'package:project_1_v2/Models/Manager/ImageModel.dart';
import 'package:project_1_v2/Screens/splash_screen.dart';
import 'package:project_1_v2/Theme/Theme_Provider.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox('mainBox');
  bool isViewed = box.get('onBoard') ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => ImageModel()),
        ChangeNotifierProvider(
          create: (BuildContext context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => LocalizationProvider(),
        ),
      ],
      child: MyApp(isViewed: isViewed),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isViewed;
  const MyApp({super.key, required this.isViewed});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LocalizationProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return DoubleTapToExit(
      child: MaterialApp(
        locale: languageProvider.language,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(isViewed: isViewed),
        theme: themeProvider.currentTheme,
      ),
    );
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
