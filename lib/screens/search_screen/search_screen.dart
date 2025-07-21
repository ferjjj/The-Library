import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_library/models/book_model.dart';
import 'package:the_library/screens/detail_screen/detail_screen.dart';
import 'package:the_library/screens/search_screen/controllers/search_controller.dart';
import 'package:the_library/utils/constants/colors.dart';
import 'package:the_library/widgets/buttons.dart';
import 'package:the_library/widgets/card_widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final controller = Get.put(SearchWordController());
    return Padding(
      padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: Column(children: [
            Container(
              width: size.width,
              height: 90,
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(children: [
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          Get.back();
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        color: primaryYellow,
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 30,
                        ),
                      ),
                    )),
                Expanded(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SearchBox(controller: controller),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Container(
                      height: 50,
                      width: 50,
                      child: MaterialButtonIcon(
                        onTap: () {
                          searchFilterDialog(
                              context: context, controller: controller);
                        },
                        withIcon: true,
                        icon: Icons.manage_search_rounded,
                        buttonColor: primaryYellow,
                      ),
                    ))
              ]),
            ),
            Expanded(
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: 10, bottom: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.suggestionList.length,
                            itemBuilder: (context, i) {
                              BookModel book = controller.suggestionList[i];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 30),
                                child: HorizontalThreeLayerWidget(
                                  image: book.bookCover,
                                  firstText: book.title,
                                  secondText: book.author,
                                  thirdText: book.isAvailable
                                      ? "Available"
                                      : "Borrowed",
                                  onPress: () {
                                    Get.to(() => DetailScreen(book: book),
                                        transition: Transition.rightToLeft,
                                        duration: Duration(milliseconds: 500));
                                  },
                                ),
                              );
                            }),
                      ),
                      Container(
                        child: Text(
                          "-- End of results --",
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: lightGrey.withOpacity(0.75)),
                        ),
                      )
                    ],
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
