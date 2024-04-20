import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/services/loading_alert.dart';
import 'package:todo_app/features/layout_view.dart';
import 'package:todo_app/features/login/pages/login_screen.dart';
import 'package:todo_app/features/register/pages/register_view.dart';
import 'package:todo_app/features/splash_screen/pages/splash_screen.dart';

import 'core/config/app_settings/settings_manager.dart';
import 'core/config/constants/application_theme_manager.dart';
import 'core/firebase_settings/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
      create: (context) => SettingsProvider(), child: const MyApp()));
  loadingAlert();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var pointer = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.lightTheme,
      darkTheme: ThemeManager.darkTheme,
      themeMode: pointer.currentTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(pointer.currentLanguage),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        LayoutView.routeName: (context) => const LayoutView(),
        RegisterPage.routeName: (context) => const RegisterPage(),
      },
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
    );
  }
}
