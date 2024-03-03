import 'package:flutter/material.dart';
import 'package:todo_app/features/settings_view/pages/settings_screen.dart';
import 'package:todo_app/features/tasks_view/pages/tasks_screen.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String currentLanguage = "en";
  List<Widget> screens = [const TasksScreen(), SettingsScreen()];
  int currentIndex = 0;
  DateTime selectedDate = DateTime.now();

  changeTime(BuildContext context) async {
    var currentSelectedTime = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        initialDate: selectedDate,
        lastDate: DateTime.now().add(const Duration(days: 366)));
    if (currentSelectedTime == null) return;
    selectedDate = currentSelectedTime;
    notifyListeners();
  }

  changeLanguage(String newLanguage) {
    if (currentLanguage == newLanguage) return;
    currentLanguage = newLanguage;
    notifyListeners();
  }

  changeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    notifyListeners();
  }

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  bool isDark() {
    return currentTheme == ThemeMode.dark;
  }
}
