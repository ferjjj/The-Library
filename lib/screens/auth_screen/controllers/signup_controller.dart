import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_library/utils/application_controller.dart';
import 'package:the_library/utils/auth/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  bool isMale = true;
  late TextEditingController email, password, firstName, lastName, phone;
  final signUpFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
    firstName = TextEditingController();
    lastName = TextEditingController();
    phone = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    email.dispose();
    password.dispose();
    firstName.dispose();
    lastName.dispose();
    phone.dispose();
  }

  Future signupUser(BuildContext context) async {
    if (signUpFormKey.currentState!.validate()) {
      await AuthenticationRepository.instance.createUserWithEmailAndPassword(
          email.text.trim(),
          password.text.trim(),
          firstName.text.trim(),
          lastName.text.trim(),
          phone.text.trim(),
          isMale);
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
