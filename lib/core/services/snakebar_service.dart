import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SnackBarService {
  static void showSuccessMsg(String msg) {
    BotToast.showCustomNotification(
        toastBuilder: (cancelFunc) {
          return Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              padding: const EdgeInsets.all(13),
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    msg,
                    style: TextStyle(
                        fontSize: msg.length > 20 ? 14 : 22,
                        color: Colors.green,
                        fontFamily: "Poppins"),
                  ),
                  Lottie.asset(
                    "assets/images/face_success_icon.json",
                    repeat: false,
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
            ),
          );
        },
        duration: const Duration(
          seconds: 7,
        ),
        dismissDirections: [DismissDirection.endToStart]);
  }

  static void showFailedMsg(String msg) {
    BotToast.showCustomNotification(
        toastBuilder: (cancelFunc) {
          return Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              padding: const EdgeInsets.only(left: 15),
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: Text(
                      msg,
                      style: TextStyle(
                          fontSize: msg.length > 20 ? 14 : 22,
                          color: Colors.redAccent,
                          fontFamily: "Poppins"),
                    ),
                  ),
                  Expanded(
                    child: Lottie.asset(
                      "assets/images/face_wrong_icon.json",
                      repeat: false,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        duration: const Duration(
          seconds: 7,
        ),
        dismissDirections: [DismissDirection.endToStart]);
  }
}
