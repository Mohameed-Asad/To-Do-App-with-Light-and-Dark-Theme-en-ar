import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/app_settings/settings_manager.dart';
import 'package:todo_app/core/config/constants/application_theme_manager.dart';
import 'package:todo_app/core/date_time.dart';
import 'package:todo_app/core/models/task_model.dart';
import 'package:todo_app/core/services/snakebar_service.dart';
import 'package:todo_app/core/widget/custom_text_form_field.dart';

import '../../../core/firebase_settings/firebase_utils.dart';

class BottomSheetModel extends StatefulWidget {
  const BottomSheetModel({super.key});

  @override
  State<BottomSheetModel> createState() => _BottomSheetModelState();
}

class _BottomSheetModelState extends State<BottomSheetModel> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    var theme = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: vm.isDark() ? Colors.white10 : Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      child: Form(
        key: globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add New Task",
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25,
            ),
            CustomTextField(
              controller: titleController,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please Enter Your Task";
                }
                return null;
              },
              hint: "What's your task?",
              hintColor: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: descController,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please Enter Your Description";
                }
                return null;
              },
              hintColor: Colors.grey,
              hint: "Description",
              maxLines: 3,
            ),
            const SizedBox(
              height: 26,
            ),
            Text(
              "Select Time",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 7,
            ),
            TextButton(
              onPressed: () {
                vm.changeTime(context);
              },
              child: Text(
                DateFormat.yMMMMd().format(vm.selectedDate),
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            FilledButton(
                onPressed: () {
                  if (globalKey.currentState!.validate()) {
                    var task = TaskModel(
                        title: titleController.text,
                        description: descController.text,
                        isDone: false,
                        date: extractDateTime(vm.selectedDate));
                    EasyLoading.show();
                    FirebaseUtils().createNewTask(task).then((value) {
                      EasyLoading.dismiss();
                      SnackBarService.showSuccessMsg("Task Added");
                      Navigator.pop(context);
                    }).onError((error, stackTrace) {
                      EasyLoading.dismiss();
                      SnackBarService.showFailedMsg("Please try again!");
                    });
                  }
                },
                style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: ThemeManager.primaryColor),
                child: Text(
                  "Add Task",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
