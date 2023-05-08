import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:reserve_library/gui/login/login_controller.dart';

class LoginGui extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.Google,
      text: "Sign up with Google",
      onPressed: () async {
        UserCredential credential = await controller.signInWithGoogle();
        final user = credential.user;

        if (user?.uid != null) {
          Get.toNamed("/");
        }
      },
    );
  }
}
