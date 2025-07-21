import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:the_library/screens/auth_screen/controllers/signup_controller.dart';
import 'package:the_library/screens/auth_screen/login_screen.dart';
import 'package:the_library/utils/constants/colors.dart';
import 'package:the_library/utils/constants/image_strings.dart';
import 'package:the_library/widgets/buttons.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.put(SignUpController());
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
                    key: controller.signUpFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          maxLines: 1,
                          controller: controller.email,
                          validator: (value) {
                            if (value != null && value != "" && value.isEmail) {
                              return null;
                            }
                            return "Invalid email";
                          },
                          style: GoogleFonts.poppins(fontSize: 18),
                          keyboardType: TextInputType.emailAddress,
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
                        OrSeparator(
                          text: "PERSONAL INFORMATION",
                          lineWidth: 2,
                          fontWeight: FontWeight.w500,
                          color: lightGrey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          maxLines: 1,
                          controller: controller.firstName,
                          validator: (value) {
                            if (value != null && value != "") {
                              return null;
                            }
                            return "Invalid first name";
                          },
                          style: GoogleFonts.poppins(fontSize: 18),
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(
                              Icons.person_rounded,
                              color: primaryPink,
                              size: 25,
                            ),
                            filled: true,
                            fillColor: lightGrey.withOpacity(0.1),
                            prefixIconConstraints: BoxConstraints(minWidth: 50),
                            hintText: "First name",
                            focusColor: primaryPink,
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
                          controller: controller.lastName,
                          validator: (value) {
                            if (value != null && value != "") {
                              return null;
                            }
                            return "Invalid last name";
                          },
                          style: GoogleFonts.poppins(fontSize: 18),
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(
                              Icons.person_outline_rounded,
                              color: primaryGreen,
                              size: 25,
                            ),
                            filled: true,
                            fillColor: lightGrey.withOpacity(0.1),
                            prefixIconConstraints: BoxConstraints(minWidth: 50),
                            hintText: "Last name",
                            focusColor: primaryGreen,
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
                          controller: controller.phone,
                          validator: (value) {
                            if (value != null &&
                                value != "" &&
                                value.length >= 11 &&
                                value.isPhoneNumber) {
                              return null;
                            }
                            return "Invalid phone number";
                          },
                          style: GoogleFonts.poppins(fontSize: 18),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(
                              Icons.phone,
                              color: primaryYellow,
                              size: 25,
                            ),
                            filled: true,
                            fillColor: lightGrey.withOpacity(0.1),
                            prefixIconConstraints: BoxConstraints(minWidth: 50),
                            hintText: "Phone Number",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You are a",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: lightGrey),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            LiteRollingSwitch(
                              value: true,
                              textOn: 'Male',
                              textOff: 'Female',
                              colorOn: primaryBlue,
                              colorOff: primaryPink,
                              iconOn: Icons.male_rounded,
                              iconOff: Icons.female_rounded,
                              textOffColor: pureWhite,
                              textOnColor: pureWhite,
                              textSize: 14.0,
                              width: 110,
                              onChanged: (bool state) {
                                controller.isMale = state;
                              },
                              onTap: () {},
                              onDoubleTap: () {},
                              onSwipe: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 60,
                          child: MaterialButtonIcon(
                            onTap: () {
                              var complete = controller
                                  .signUpFormKey.currentState!
                                  .validate();
                              if (complete) {
                                controller.signupUser(context);
                              }
                            },
                            withIcon: false,
                            withText: true,
                            text: "SIGN UP",
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            buttonColor: primaryGreen,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Already have an account?",
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: lightGrey),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.off(() => LoginScreen(),
                                  transition: Transition.leftToRight);
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ))),
                            child: Text(
                              "Log in instead",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: primaryPink,
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
