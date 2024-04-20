import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/app_settings/settings_manager.dart';
import 'package:todo_app/features/tasks_view/widgets/task_filed.dart';

import '../../../core/firebase_settings/firebase_utils.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  DateTime focusDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    var loocal = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    Size mediaQuery = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 65),
          child: Stack(alignment: const Alignment(0, 2.1), children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
              width: mediaQuery.width,
              height: mediaQuery.height * 0.24,
              color: theme.primaryColor,
              child: Text(loocal.todoTitle,
                  style: vm.isDark()
                      ? theme.textTheme.titleLarge
                          ?.copyWith(color: Colors.black)
                      : theme.textTheme.titleLarge),
            ),
            EasyInfiniteDateTimeLine(
              locale: vm.currentLanguage,
              timeLineProps: const EasyTimeLineProps(separatorPadding: 8),
              dayProps: EasyDayProps(
                  width: 75,
                  todayStyle: DayStyle(
                      dayNumStyle: vm.isDark()
                          ? theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.white)
                          : theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.grey),
                      monthStrStyle: vm.isDark()
                          ? theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white)
                          : theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey),
                      dayStrStyle: vm.isDark()
                          ? theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.white)
                          : theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.grey),
                      decoration: BoxDecoration(
                          color: vm.isDark() ? Colors.black54 : Colors.white70,
                          borderRadius: BorderRadius.circular(12))),
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                        color: vm.isDark() ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    dayStrStyle: theme.textTheme.bodySmall,
                    monthStrStyle: theme.textTheme.bodyMedium,
                    dayNumStyle: theme.textTheme.bodyLarge,
                  ),
                  inactiveDayStyle: DayStyle(
                      dayNumStyle: vm.isDark()
                          ? theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.white)
                          : theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.grey),
                      monthStrStyle: vm.isDark()
                          ? theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white)
                          : theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey),
                      dayStrStyle: vm.isDark()
                          ? theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.white)
                          : theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.grey),
                      decoration: BoxDecoration(
                          color: vm.isDark() ? Colors.black87 : Colors.white,
                          borderRadius: BorderRadius.circular(12)))),
              showTimelineHeader: false,
              firstDate: DateTime(2023),
              focusDate: focusDay,
              lastDate: DateTime(2025),
              onDateChange: (selectedDate) {
                focusDay = selectedDate;
                vm.selectedDate = focusDay;
                setState(() {});
              },
            ),
          ]),
        ),
        StreamBuilder(
          stream: FirebaseUtils().streamGetData(vm.selectedDate),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            var tasksList =
                snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
            return Expanded(
                child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: tasksList.length,
              itemBuilder: (context, index) =>
                  TaskField(taskModel: tasksList[index]),
            ));
          },
        )
      ],
    );
  }
}
