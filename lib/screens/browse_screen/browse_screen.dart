import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_library/models/book_model.dart';
import 'package:the_library/screens/detail_screen/detail_screen.dart';
import 'package:the_library/screens/search_screen/search_screen.dart';
import 'package:the_library/utils/application_controller.dart';
import 'package:the_library/utils/constants/colors.dart';
import 'package:the_library/utils/constants/image_strings.dart';
import 'package:the_library/widgets/buttons.dart';
import 'package:the_library/widgets/card_widgets.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Column(children: [
        Container(
          width: size.width,
          height: 90,
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Row(children: [
            Expanded(
              child: Container(
                height: 90,
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "BROWSE",
                      style: GoogleFonts.poppins(
                        color: lightGrey,
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 40,
                      child: Image.asset(
                        iTheLibraryBrowse,
                        fit: BoxFit.contain,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: Container(
                  height: 50,
                  width: 50,
                  child: MaterialButtonIcon(
                    onTap: () {
                      Get.to(() => SearchScreen(),
                          transition: Transition.upToDown,
                          duration: Duration(milliseconds: 500));
                    },
                    withIcon: true,
                    icon: Icons.search,
                    buttonColor: primaryYellow,
                  ),
                ))
          ]),
        ),
        Expanded(
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 10, bottom: 30),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ApplicationController.instance.listBooks.length,
                  itemBuilder: (context, i) {
                    BookModel book =
                        ApplicationController.instance.listBooks[i];
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                      child: HorizontalThreeLayerWidget(
                        image: book.bookCover,
                        firstText: book.title,
                        secondText: book.author,
                        thirdText: book.isAvailable ? "Available" : "Borrowed",
                        onPress: () {
                          Get.to(() => DetailScreen(book: book),
                              transition: Transition.rightToLeft,
                              duration: Duration(milliseconds: 500));
                        },
                      ),
                    );
                  })),
        )
      ]),
    );
  }
}
