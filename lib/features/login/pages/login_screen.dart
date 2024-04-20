import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/core/config/constants/application_theme_manager.dart';
import 'package:todo_app/core/services/snakebar_service.dart';
import 'package:todo_app/core/widget/custom_text_form_field.dart';
import 'package:todo_app/features/layout_view.dart';
import 'package:todo_app/features/register/pages/register_view.dart';

import '../../../core/firebase_settings/firebase_utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "Login Screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var loocal = AppLocalizations.of(context)!;
    Size mediaQuery = MediaQuery.of(context).size;
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
          title: Text(loocal.login),
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
                    height: mediaQuery.height * 0.17,
                  ),
                  Text(
                    loocal.welcomeBack,
                    style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
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
                        return null;
                      }),
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
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 7),
                    child: FilledButton(
                      onPressed: () {
                        if (globalKey.currentState!.validate()) {
                          FirebaseUtils()
                              .signIn(_emailController.text,
                              _passwordController.text)
                              .then((value) {
                            if (value == true) {
                              EasyLoading.dismiss();
                              SnackBarService.showSuccessMsg(
                                  loocal.loginSuccess);
                              Navigator.pushReplacementNamed(
                                  context, LayoutView.routeName);
                            }
                            EasyLoading.dismiss();
                          });
                        }
                        ;
                      },
                      style: FilledButton.styleFrom(
                          backgroundColor: ThemeManager.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13))),
                      child: Text(
                        loocal.login,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    loocal.or,
                    style: theme.textTheme.titleLarge
                        ?.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterPage.routeName);
                    },
                    child: Text(
                      loocal.createNewAcc,
                      style: theme.textTheme.bodyMedium?.copyWith(fontSize: 18),
                      textAlign: TextAlign.center,
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
