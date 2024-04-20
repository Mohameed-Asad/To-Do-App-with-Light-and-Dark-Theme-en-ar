import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/tasks_view/widgets/bottom_sheet.dart';

import '../core/config/app_settings/settings_manager.dart';

class LayoutView extends StatelessWidget {
  static const String routeName = "Layout View";

  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    var pointer = Provider.of<SettingsProvider>(context);
    return Scaffold(
      extendBody: true,
      backgroundColor:
          pointer.isDark() ? const Color(0xFF060E1E) : const Color(0xFFDFECDB),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => const BottomSheetModel(),
              backgroundColor: Colors.transparent);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),
      body: pointer.screens[pointer.currentIndex],
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          onTap: pointer.changeIndex,
          currentIndex: pointer.currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: "Settings"),
          ],
        ),
      ),
    );
  }
}
