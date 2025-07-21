import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_library/screens/auth_screen/controllers/login_controller.dart';
import 'package:the_library/screens/auth_screen/signup_screen.dart';
import 'package:the_library/utils/constants/colors.dart';
import 'package:the_library/utils/constants/image_strings.dart';
import 'package:the_library/widgets/buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.put(LoginController());
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(color: pureWhite),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: min(size.width, size.height) * 0.7,
                width: min(size.width, size.height) * 0.7,
                constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.asset(iTheLibraryIcon),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                child: Form(
                    key: controller.loginFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          maxLines: 1,
                          controller: controller.email,
                          validator: (value) {
                            if (value != null && value != "") {
                              return null;
                            }
                            return "Invalid email";
                          },
                          style: GoogleFonts.poppins(fontSize: 18),
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(
                              Icons.email,
                              color: primaryYellow,
                              size: 25,
                            ),
                            filled: true,
                            fillColor: lightGrey.withOpacity(0.1),
                            prefixIconConstraints: BoxConstraints(minWidth: 50),
                            hintText: "Email",
                            focusColor: primaryYellow,
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red.shade700),
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          maxLines: 1,
                          controller: controller.password,
                          obscureText: true,
                          validator: (value) {
                            if (value != null && value.length >= 6) {
                              return null;
                            }
                            return "Invalid password";
                          },
                          style: GoogleFonts.poppins(fontSize: 18),
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(
                              Icons.key,
                              color: primaryBlue,
                              size: 25,
                            ),
                            filled: true,
                            fillColor: lightGrey.withOpacity(0.1),
                            prefixIconConstraints: BoxConstraints(minWidth: 50),
                            hintText: "Password",
                            focusColor: primaryBlue,
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30)),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red.shade700),
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 60,
                          child: MaterialButtonIcon(
                            onTap: () {
                              var complete = controller
                                  .loginFormKey.currentState!
                                  .validate();
                              if (complete) {
                                controller.loginUser(context);
                              }
                            },
                            withIcon: false,
                            withText: true,
                            text: "LOG IN",
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Don't have an account?",
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: lightGrey),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.off(() => SignupScreen(),
                                  transition: Transition.rightToLeft);
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ))),
                            child: Text(
                              "Sign up instead",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: primaryYellow,
                                  fontWeight: FontWeight.w600),
                            )),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
