import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/app_settings/settings_manager.dart';
import '../../../core/config/constants/application_theme_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  List<String> languages = [
    "English",
    "عربي",
  ];
  List<String> themes = [
    "Light",
    "Dark",
  ];

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var loocal = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);
    Size mediaQuery = MediaQuery.of(context).size;

    return Column(children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
        width: mediaQuery.width,
        height: mediaQuery.height * 0.24,
        color: ThemeManager.primaryColor,
        child: Text(loocal.settings,
            style: vm.isDark()
                ? theme.textTheme.titleLarge?.copyWith(color: Colors.black)
                : theme.textTheme.titleLarge),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              loocal.languages,
              style: vm.isDark()
                  ? theme.textTheme.bodyLarge
                      ?.copyWith(color: Colors.white, fontSize: 23)
                  : theme.textTheme.bodyLarge
                      ?.copyWith(color: Colors.black, fontSize: 23),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDropdown(
                items: languages,
                onChanged: (value) {
                  if (value == "English") {
                    vm.changeLanguage("en");
                  } else if (value == "عربي") {
                    vm.changeLanguage("ar");
                  }
                },
                initialItem: vm.currentLanguage == "en" ? "English" : "عربي",
                decoration: CustomDropdownDecoration(
                  headerStyle:
                      theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                  listItemStyle:
                      theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                )),
            const SizedBox(
              height: 20,
            ),
            Text(
              loocal.themeMode,
              style: vm.isDark()
                  ? theme.textTheme.bodyLarge
                      ?.copyWith(color: Colors.white, fontSize: 23)
                  : theme.textTheme.bodyLarge
                      ?.copyWith(color: Colors.black, fontSize: 23),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDropdown(
                initialItem:
                    vm.currentTheme == ThemeMode.dark ? "Dark" : "Light",
                items: themes,
                onChanged: (value) {
                  if (value == "Dark") {
                    vm.changeTheme(ThemeMode.dark);
                  } else if (value == "Light") {
                    vm.changeTheme(ThemeMode.light);
                  }
                },
                decoration: CustomDropdownDecoration(
                  headerStyle:
                      theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                  listItemStyle:
                      theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                ))
          ],
        ),
      )
    ]);
  }
}
