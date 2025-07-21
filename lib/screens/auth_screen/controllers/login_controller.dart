import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_library/utils/application_controller.dart';
import 'package:the_library/utils/auth/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  late TextEditingController email, password;
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    email.dispose();
    password.dispose();
  }

  Future loginUser(BuildContext context) async {
    if (loginFormKey.currentState!.validate()) {
      await AuthenticationRepository.instance.loginUserWithEmailAndPassword(
          email.text.trim(), password.text.trim());
      await ApplicationController.instance.updateTransactions();
      if (ApplicationController.instance.loggedInUser != null) {
        await ApplicationController.instance.updateUserTransactions(
            ApplicationController.instance.loggedInUser!.uid);
      }
    } else {
      Get.snackbar("Form error", "Please check your inputs before proceeding.");
    }
  }
}
