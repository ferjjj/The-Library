import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_library/models/book_model.dart';
import 'package:the_library/screens/detail_screen/detail_screen.dart';
import 'package:the_library/utils/application_controller.dart';
import 'package:the_library/utils/auth/authentication_repository.dart';
import 'package:the_library/utils/constants/colors.dart';
import 'package:the_library/utils/constants/image_strings.dart';
import 'package:the_library/widgets/buttons.dart';
import 'package:the_library/widgets/card_widgets.dart';
import 'package:the_library/widgets/custom.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Column(children: [
        Container(
          width: size.width,
          height: 180, //230
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [
              Row(children: [
                Container(
                  height: 90,
                  width: 90,
                  padding: EdgeInsets.all(15),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.asset(
                        ApplicationController.instance.loggedInUser?.isMale ??
                                true
                            ? iMale
                            : iFemale),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${ApplicationController.instance.loggedInUser?.firstName ?? "User"} ${ApplicationController.instance.loggedInUser?.lastName ?? "name"}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: mediumGray,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                        Text(
                          "${ApplicationController.instance.loggedInUser?.email ?? "user@email.com"}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: lightGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                          ),
                        ),
                        Text(
                          "${ApplicationController.instance.loggedInUser?.phoneNo ?? "09XXXXXXXXX"}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: lightGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  padding: EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
                      AuthenticationRepository.instance.logoutUser();
                    },
                    padding: EdgeInsets.all(0.0),
                    iconSize: 35,
                    icon: Icon(
                      Icons.logout,
                      //Icons.edit_note_rounded,
                      color: primaryPink,
                    ),
                  ),
                )
              ]),
              Container(
                height: 45,
                child: MaterialButtonIcon(
                  onTap: () {
                    showUserQR(
                        context: context,
                        size: size,
                        userID:
                            "${ApplicationController.instance.loggedInUser?.uid ?? "User"}");
                  },
                  withIcon: true,
                  withText: true,
                  text: "MY CHECKOUT QR",
                  fontColor: primaryGreen,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  icon: Icons.qr_code_rounded,
                  iconSize: 35,
                  iconColor: primaryGreen,
                  buttonColor: Colors.transparent,
                  iconTextDistance: 10,
                  withOutline: true,
                  withShadow: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Container(
              //   height: 45,
              //   child: MaterialButtonIcon(
              //     onTap: () {},
              //     withIcon: true,
              //     withText: true,
              //     text: "MY BOOKMARKS",
              //     fontColor: primaryYellow,
              //     fontSize: 18,
              //     fontWeight: FontWeight.w600,
              //     icon: Icons.bookmark_outline_rounded,
              //     iconSize: 35,
              //     iconColor: primaryYellow,
              //     buttonColor: Colors.transparent,
              //     iconTextDistance: 10,
              //     withOutline: true,
              //     withShadow: false,
              //   ),
              // )
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 10, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ApplicationController.instance.userActiveTransactions.length !=
                        0
                    ? AnnouncementCard(
                        size: size,
                        text:
                            'A borrowed book shall be returned by ${ApplicationController.instance.userActiveTransactions[0].dateToReturn}.',
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "Active checkouts",
                    style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: muteBlack,
                        height: 1.3),
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      strokeCap: StrokeCap.round,
                      radius: Radius.circular(20),
                      padding: EdgeInsets.all(15),
                      strokeWidth: 3,
                      dashPattern: [10, 10],
                      color: lightGrey.withOpacity(0.5),
                      child: ApplicationController
                                  .instance.userActiveTransactions.length ==
                              0
                          ? Container(
                              alignment: Alignment.center,
                              child: Text(
                                "NONE",
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: lightGrey),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: ApplicationController
                                  .instance.userActiveTransactions.length,
                              itemBuilder: (context, i) {
                                BookModel book = ApplicationController
                                    .instance.listBooks
                                    .firstWhere((e) =>
                                        e.id ==
                                        ApplicationController.instance
                                            .userActiveTransactions[i].bookId);
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: HorizontalThreeLayerWidget(
                                    image: book.bookCover,
                                    firstText: book.title,
                                    secondText: book.author,
                                    thirdText:
                                        "${ApplicationController.instance.userActiveTransactions[i].dateBorrowed} to ${ApplicationController.instance.userActiveTransactions[i].dateToReturn} ",
                                    onPress: () {
                                      Get.to(() => DetailScreen(book: book),
                                          transition: Transition.rightToLeft,
                                          duration:
                                              Duration(milliseconds: 500));
                                    },
                                  ),
                                );
                              }),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "Checkout History",
                    style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: muteBlack,
                        height: 1.3),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: ApplicationController
                              .instance.userAllTransactions.length ==
                          0
                      ? Container(
                          alignment: Alignment.center,
                          child: Text(
                            "NONE",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: lightGrey),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: ApplicationController
                              .instance.userAllTransactions.length,
                          itemBuilder: (context, i) {
                            BookModel book = ApplicationController
                                .instance.listBooks
                                .firstWhere((e) =>
                                    e.id ==
                                    ApplicationController.instance
                                        .userAllTransactions[i].bookId);
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: HorizontalThreeLayerWidget(
                                image: book.bookCover,
                                firstText: book.title,
                                secondText: book.author,
                                thirdText:
                                    "${ApplicationController.instance.userAllTransactions[i].dateBorrowed} to ${ApplicationController.instance.userAllTransactions[i].dateToReturn} ",
                                onPress: () {
                                  Get.to(() => DetailScreen(book: book),
                                      transition: Transition.rightToLeft,
                                      duration: Duration(milliseconds: 500));
                                },
                              ),
                            );
                          }),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
