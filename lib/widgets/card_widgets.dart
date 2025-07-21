import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_library/models/book_model.dart';
import 'package:the_library/utils/constants/colors.dart';
import 'package:the_library/utils/constants/image_strings.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({
    super.key,
    required this.size,
    required this.text,
  });

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      child: Stack(children: [
        Container(
          width: size.width,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Container(
            alignment: Alignment.topLeft,
            constraints: BoxConstraints(minHeight: 80),
            width: size.width - 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: primaryYellow,
                boxShadow: [lightShadow()]),
            child: Container(
              width: size.width - 160,
              padding: EdgeInsets.fromLTRB(30, 20, 0, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "THE LIBRARY CAT",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        letterSpacing: 2,
                        fontSize: 14,
                        color: pureWhite,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    text,
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: mediumGray,
                        fontWeight: FontWeight.w500,
                        height: 1.3),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: -5,
            right: 0,
            child: Container(
              height: 120,
              width: 120,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset(iTheLibraryCat),
              ),
            ))
      ]),
    );
  }
}

class HorizontalThreeLayerWidget extends StatelessWidget {
  const HorizontalThreeLayerWidget({
    super.key,
    this.image,
    required this.firstText,
    required this.secondText,
    required this.thirdText,
    this.thirdColor,
    this.onPress,
    this.isBookmarked,
    this.isBook = true,
    this.book,
  });

  final String? image;
  final String firstText;
  final String secondText;
  final String thirdText;
  final Color? thirdColor;
  final VoidCallback? onPress;
  final bool? isBookmarked;
  final bool isBook;
  final BookModel? book;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          height: 115,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: pureWhite,
              boxShadow: [lightShadow()]),
          child: Stack(
            children: [
              Container(
                height: 115,
                width: double.infinity,
                padding: EdgeInsets.all(12.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isBook ? lightGrey.withOpacity(0.5) : null,
                        image: image != null
                            ? isBook
                                ? DecorationImage(
                                    image: NetworkImage(image!),
                                    fit: BoxFit.cover)
                                : DecorationImage(
                                    image: AssetImage(
                                        image == "true" ? iMale : iFemale),
                                    fit: BoxFit.contain)
                            : null),
                    child: image == null
                        ? Icon(
                            Icons.menu_book_rounded,
                            size: 40,
                            color: pureWhite.withOpacity(0.5),
                          )
                        : null,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          firstText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: muteBlack,
                              fontWeight: FontWeight.w600,
                              height: 1.3),
                        ),
                        Text(
                          secondText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: lightGrey,
                              fontWeight: FontWeight.w300,
                              height: 1.2),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          thirdText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: thirdColor ?? primaryBlue,
                              fontWeight: FontWeight.w500,
                              height: 1.2),
                        )
                      ],
                    ),
                  ))
                ]),
              ),
              isBookmarked ?? false
                  ? Positioned(
                      top: -5,
                      right: 20,
                      child: Icon(
                        Icons.bookmark,
                        size: 30,
                        color: primaryYellow,
                      ))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

class VerticalThreeLayerWidget extends StatelessWidget {
  const VerticalThreeLayerWidget({
    super.key,
    this.image,
    required this.firstText,
    required this.secondText,
    required this.thirdText,
    this.thirdColor,
    required this.onPress,
    this.isBookmarked,
  });

  final String? image;
  final String firstText;
  final String secondText;
  final String thirdText;
  final Color? thirdColor;
  final VoidCallback onPress;
  final bool? isBookmarked;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          width: 130,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: pureWhite,
              boxShadow: [lightShadow()]),
          child: Stack(
            children: [
              Container(
                width: 130,
                padding: EdgeInsets.all(12.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(children: [
                  Container(
                    height: 105,
                    width: 105,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: lightGrey.withOpacity(0.5),
                        image: image != null
                            ? DecorationImage(
                                image: NetworkImage(image!), fit: BoxFit.cover)
                            : null),
                    child: image == null
                        ? Icon(
                            Icons.menu_book_rounded,
                            size: 40,
                            color: pureWhite.withOpacity(0.5),
                          )
                        : null,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          firstText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: muteBlack,
                              fontWeight: FontWeight.w600,
                              height: 1.2),
                        ),
                        Text(
                          secondText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: lightGrey,
                              fontWeight: FontWeight.w300,
                              height: 1.1),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          thirdText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: thirdColor ?? primaryBlue,
                              fontWeight: FontWeight.w500,
                              height: 1.1),
                        )
                      ],
                    ),
                  )
                ]),
              ),
              isBookmarked ?? false
                  ? Positioned(
                      top: -5,
                      right: 20,
                      child: Icon(
                        Icons.bookmark,
                        size: 30,
                        color: primaryYellow,
                      ))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
