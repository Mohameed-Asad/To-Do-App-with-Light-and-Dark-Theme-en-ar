import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/app_settings/settings_manager.dart';
import 'package:todo_app/core/models/task_model.dart';
import 'package:todo_app/core/services/snakebar_service.dart';

import '../../../core/config/constants/application_theme_manager.dart';
import '../../../core/firebase_settings/firebase_utils.dart';

class TaskField extends StatelessWidget {
  final TaskModel taskModel;

  const TaskField({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    var theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: const Color(0xFFFE4A49)),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.270,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                EasyLoading.show();
                FirebaseUtils().deleteTask(taskModel).then(
                  (value) {
                    EasyLoading.dismiss();
                    SnackBarService.showSuccessMsg("Task Deleted");
                  },
                );
              },
              backgroundColor: const Color(0xFFFE4A49),
              borderRadius: BorderRadius.circular(12),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          width: MediaQuery.of(context).size.width,
          height: 115,
          decoration: BoxDecoration(
              color: vm.isDark() ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(17)),
          child: Row(
            children: [
              Container(
                color: ThemeManager.primaryColor,
                width: 4,
                height: 60,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskModel.title,
                      style: theme.textTheme.bodyLarge?.copyWith(fontSize: 18),
                    ),
                    Text(
                      taskModel.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: vm.isDark()
                          ? theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey)
                          : theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.black,
                            ),
                    ),
                    // const SizedBox(height: 10,),
                    Row(children: [
                      const Icon(Icons.watch_later_outlined,
                          color: Colors.grey),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        DateFormat.yMMMMd().format(taskModel.date),
                        style: const TextStyle(color: Colors.grey),
                      )
                    ])
                  ],
                ),
              ),
              const Spacer(),
              if (taskModel.isDone)
                Text(
                  "Done !",
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.green),
                ),
              if (!taskModel.isDone)
                FilledButton(
                    onPressed: () {
                      FirebaseUtils().updateTask(taskModel);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: ThemeManager.primaryColor,
                    ),
                    child: const Icon(
                      Icons.check_sharp,
                      color: Colors.white,
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
