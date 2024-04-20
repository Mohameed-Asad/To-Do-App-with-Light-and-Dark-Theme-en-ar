import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/core/services/snakebar_service.dart';
import 'package:todo_app/features/login/pages/login_screen.dart';

import '../../../core/config/constants/application_theme_manager.dart';
import '../../../core/firebase_settings/firebase_utils.dart';
import '../../../core/widget/custom_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = "Register Page";

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var loocal = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    return Container(
      decoration: const BoxDecoration(
          color: ThemeManager.primaryColor2,
          image: DecorationImage(
              image: AssetImage("assets/images/pattern.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(loocal.createAcc),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.16,
                  ),
                  Text(
                    loocal.name,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.black, fontSize: 17),
                  ),
                  CustomTextField(
                    controller: _nameController,
                    hint: loocal.nameHint,
                    hintColor: Colors.grey,
                    suffixWidget: const Icon(Icons.person),
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return loocal.nameHint;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Text(
                    loocal.email,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.black, fontSize: 17),
                  ),
                  CustomTextField(
                    controller: _emailController,
                    hint: loocal.emailHint,
                    hintColor: Colors.grey,
                    suffixWidget: const Icon(Icons.email),
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return loocal.emailHint;
                      }
                      var regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (!regex.hasMatch(value)) {
                        return loocal.emailHint;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Text(
                    loocal.password,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.black, fontSize: 17),
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    hint: loocal.passwordHint,
                    hintColor: Colors.grey,
                    maxLines: 1,
                    isPassword: true,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return loocal.passwordHint;
                      }
                      var regex = RegExp(
                          r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$");
                      if (!regex.hasMatch(value)) {
                        return "The password must include at least \n* one lowercase letter, \n* one uppercase letter, \n* one digit, \n* one special character,\n* at least 8 characters long.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Text(
                    loocal.againPassword,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.black, fontSize: 17),
                  ),
                  CustomTextField(
                    controller: _confirmController,
                    hint: loocal.confirmPassword,
                    hintColor: Colors.grey,
                    maxLines: 1,
                    isPassword: true,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return loocal.confirmPassword;
                      }
                      if (value != _passwordController.text) {
                        return "Your Password doesn't match";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 7),
                    child: FilledButton(
                      onPressed: () {
                        if (globalKey.currentState!.validate()) {
                          FirebaseUtils()
                              .createNewAccount(_emailController.text,
                              _passwordController.text)
                              .then((value) {
                            if (value == true) {
                              EasyLoading.dismiss();
                              SnackBarService.showSuccessMsg(
                                  loocal.createdSuccess);
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            }
                          });
                        }
                      },
                      style: FilledButton.styleFrom(
                          backgroundColor: ThemeManager.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13))),
                      child: Text(
                        loocal.createAcc,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
