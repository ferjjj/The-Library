import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:the_library/models/book_model.dart';
import 'package:the_library/screens/browse_screen/browse_screen.dart';
import 'package:the_library/screens/checkout_screen/checkout_screen.dart';
import 'package:the_library/screens/checkout_screen/return_screen.dart';
import 'package:the_library/screens/detail_screen/detail_screen.dart';
import 'package:the_library/screens/home_screen/controllers/home_screen_controller.dart';
import 'package:the_library/screens/profile_screen/profile_screen.dart';
import 'package:the_library/utils/application_controller.dart';
import 'package:the_library/utils/constants/colors.dart';
import 'package:the_library/utils/constants/image_strings.dart';
import 'package:the_library/widgets/card_widgets.dart';
import 'package:the_library/widgets/custom.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final controller = Get.put(HomeScreenController());
    return Padding(
      padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
      child: Scaffold(
        floatingActionButton:
            ApplicationController.instance.loggedInUser!.isLibrarian
                ? Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          heroTag: "btn1",
                          backgroundColor: primaryPink,
                          onPressed: () {
                            Get.to(() => ReturnScreen());
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          tooltip: "Return",
                          // label: Text("Return",
                          //     style: GoogleFonts.poppins(
                          //         fontSize: 20,
                          //         fontWeight: FontWeight.w600,
                          //         color: pureWhite)),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.book_outlined,
                              size: 30,
                              color: pureWhite,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FloatingActionButton.extended(
                          heroTag: "btn2",
                          backgroundColor: primaryBlue,
                          onPressed: () {
                            // for (Map<String, dynamic> entry in sampleData) {
                            //   BookModel book = BookModel(
                            //       id: uuid.v1(),
                            //       title: entry["title"],
                            //       author: entry["author"],
                            //       yearPublished: entry["yearPublished"],
                            //       synopsis: entry["synopsis"],
                            //       genre: entry["genre"],
                            //       otherDetails: entry["otherDetails"],
                            //       bookCover: entry["bookCover"],
                            //       isAvailable: true);
                            //   DatabaseRepository.instance.createBook(book);
                            // }
                            // DatabaseRepository.instance.updateCategories(sampleCategoriesList);
                            Get.to(() => CheckoutScreen());
                          },
                          tooltip: "Checkout",
                          label: Text("Checkout",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: pureWhite)),
                          icon: Icon(
                            Icons.qr_code_scanner_rounded,
                            size: 30,
                            color: pureWhite,
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration:
              BoxDecoration(color: pureWhite, boxShadow: [lightShadow()]),
          child: Obx(
            () => GNav(
                selectedIndex: controller.currentPage.value,
                onTabChange: (value) {
                  controller.currentPage.value = value;
                  controller.pageController.animateToPage(value,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                },
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                rippleColor: lightGrey.withOpacity(0.3),
                hoverColor: lightGrey.withOpacity(0.3),
                haptic: true,
                tabBorderRadius: 50,
                duration: Duration(milliseconds: 300),
                gap: 10,
                color: lightGrey,
                iconSize: 30,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                tabs: [
                  GButton(
                    icon: Icons.home_rounded,
                    text: "Home",
                    iconActiveColor: primaryGreen,
                    textColor: primaryGreen,
                    backgroundColor: primaryGreen.withOpacity(0.3),
                    textStyle: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: primaryGreen),
                  ),
                  GButton(
                    icon: Icons.menu_book_rounded,
                    text: "Browse",
                    iconActiveColor: primaryYellow,
                    textColor: primaryYellow,
                    backgroundColor: primaryYellow.withOpacity(0.3),
                    textStyle: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: primaryYellow),
                  ),
                  GButton(
                    icon: Icons.person_rounded,
                    text: "Profile",
                    iconActiveColor: primaryPink,
                    textColor: primaryPink,
                    backgroundColor: primaryPink.withOpacity(0.3),
                    textStyle: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: primaryPink),
                  )
                ]),
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          child: PageView(
            physics: BouncingScrollPhysics(),
            controller: controller.pageController,
            onPageChanged: (value) {
              controller.currentPage.value = value;
            },
            children: [HomePage(), BrowsePage(), ProfilePage()],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appController = Get.find<ApplicationController>();
    return Container(
      height: size.height,
      width: size.width,
      child: Column(children: [
        Container(
          width: size.width,
          height: 120,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Row(children: [
            Container(
              height: 90,
              width: 90,
              padding: EdgeInsets.all(15),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset(appController.loggedInUser?.isMale ?? true
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
                      "Hi ${appController.loggedInUser?.firstName ?? "user"}!",
                      style: GoogleFonts.poppins(
                        color: mediumGray,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                    Text(
                      "${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('MMMMd').format(DateTime.now())}",
                      style: GoogleFonts.poppins(
                        color: muteBlack,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  showUserQR(
                      context: context,
                      size: size,
                      userID: appController.loggedInUser?.uid ?? "user");
                },
                iconSize: 35,
                icon: Icon(
                  Icons.qr_code_rounded,
                  color: primaryGreen,
                ),
              ),
            )
          ]),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 10, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                appController.userActiveTransactions.length != 0
                    ? AnnouncementCard(
                        size: size,
                        text:
                            'A borrowed book shall be returned by ${appController.userActiveTransactions[0].dateToReturn}.',
                      )
                    : Container(),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "Featured books",
                    style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: muteBlack,
                        height: 1.3),
                  ),
                ),
                appController.featuredBooks.length != 0
                    ? Container(
                        height: 205,
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: appController.featuredBooks.length,
                                itemBuilder: (context, i) {
                                  BookModel book = appController.listBooks
                                      .firstWhere((e) =>
                                          e.id ==
                                          appController.featuredBooks[i]);
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: VerticalThreeLayerWidget(
                                      image: book.bookCover,
                                      firstText: book.title,
                                      secondText: book.author,
                                      thirdText: book.isAvailable
                                          ? "Available"
                                          : "Borrowed",
                                      onPress: () {
                                        Get.to(() => DetailScreen(book: book),
                                            transition: Transition.rightToLeft,
                                            duration:
                                                Duration(milliseconds: 500));
                                      },
                                    ),
                                  );
                                })),
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: Text(
                          "NONE",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: lightGrey),
                        ),
                      ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "New Books",
                    style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: muteBlack,
                        height: 1.3),
                  ),
                ),
                appController.newBooks.length != 0
                    ? Container(
                        height: 205,
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: appController.newBooks.length,
                                itemBuilder: (context, i) {
                                  BookModel book = appController.listBooks
                                      .firstWhere((e) =>
                                          e.id == appController.newBooks[i]);
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: VerticalThreeLayerWidget(
                                      image: book.bookCover,
                                      firstText: book.title,
                                      secondText: book.author,
                                      thirdText: book.isAvailable
                                          ? "Available"
                                          : "Borrowed",
                                      onPress: () {
                                        Get.to(() => DetailScreen(book: book),
                                            transition: Transition.rightToLeft,
                                            duration:
                                                Duration(milliseconds: 500));
                                      },
                                    ),
                                  );
                                })),
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: Text(
                          "NONE",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: lightGrey),
                        ),
                      ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "Popular books",
                    style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: muteBlack,
                        height: 1.3),
                  ),
                ),
                appController.popularBooks.length != 0
                    ? Container(
                        height: 205,
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: appController.popularBooks.length,
                                itemBuilder: (context, i) {
                                  BookModel book = appController.listBooks
                                      .firstWhere((e) =>
                                          e.id ==
                                          appController.popularBooks[i]);
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: VerticalThreeLayerWidget(
                                      image: book.bookCover,
                                      firstText: book.title,
                                      secondText: book.author,
                                      thirdText: book.isAvailable
                                          ? "Available"
                                          : "Borrowed",
                                      onPress: () {
                                        Get.to(() => DetailScreen(book: book),
                                            transition: Transition.rightToLeft,
                                            duration:
                                                Duration(milliseconds: 500));
                                      },
                                    ),
                                  );
                                })),
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: Text(
                          "NONE",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: lightGrey),
                        ),
                      ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
