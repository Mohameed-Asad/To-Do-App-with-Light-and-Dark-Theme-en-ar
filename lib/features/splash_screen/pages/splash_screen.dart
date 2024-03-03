import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/app_settings/settings_manager.dart';
import 'package:todo_app/features/layout_view.dart';
import 'package:todo_app/features/login/pages/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    return Image.asset(
      vm.isDark()
          ? "assets/images/splash _dark.png"
          : "assets/images/splash.png",
      fit: BoxFit.cover,
    );
  }
}
